module uim.languages.sql.parsers.builders.create.tables.foreignref;

import uim.languages.sql;

@safe:

// Builds the FOREIGN KEY REFERENCES statement part of CREATE TABLE. */
class ForeignRefBuilder : DSqlBuilder {

    protected string buildTable(Json parsedSql) {
        auto builder = new TableBuilder();
        return builder.build(parsedSql, 0);
    }

    protected string buildColumnList(Json parsedSql) {
        auto builder = new ColumnListBuilder();
        return builder.build(parsedSql);
    }

    protected string buildReserved(Json parsedSql) {
        auto builder = new ReservedBuilder();
        return builder.build(parsedSql);
    }

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("REFERENCE")) {
            return "";
        }
        string mySql = parsedSql["sub_tree"].byKeyValue
            .map!(kv => buildKeyValue(kv.key, kv.value))
            .join;

        return subString(mySql, 0, -1);
    }

    protected string buildKeyValue(string aKey, Json aValue) {
        string result;

        result ~= this.buildTable(aValue);
        result ~= this.buildReserved(aValue);
        result ~= this.buildColumnList(aValue);

        if (result.isEmpty) { // No change
            throw new UnableToCreateSQLException("CREATE TABLE foreign ref subtree", aKey, aValue, "expr_type");
        }

        result ~= " ";
        return result;
    }
}

unittest {
  auto builder = new ForeignRefBuilder;
  assert(builder, "Could not create ForeignRefBuilder");
}
module uim.languages.sql.parsers.builders.create.tables.collation;

import uim.languages.sql;

@safe:

// Builds the collation expression part of CREATE TABLE.
class CollationBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("COLLATE")) {
            return "";
        }

        string mySql = parsedSql["sub_tree"];
        return subString(mySql, 0, -1);
    }

    protected string buildKeyValue(string aKey, Json aValue) {
        string result;
        result ~= this.buildReserved(myValue);
        result ~= this.buildOperator(myValue);
        result ~= this.buildConstant(myValue);

        if (result.isEmpty) { // No change
            throw new UnableToCreateSQLException("CREATE TABLE options collation subtree", aKey, aValue, "expr_type");
        }

        result ~= " ";
        return result;
    }

    protected string buildOperator(Json parsedSql) {
        auto builder = new OperatorBuilder();
        return builder.build(parsedSql);
    }

    protected string buildConstant(Json parsedSql) {
        auto builder = new ConstantBuilder();
        return builder.build(parsedSql);
    }

    protected string buildReserved(Json parsedSql) {
        auto builder = new ReservedBuilder();
        return builder.build(parsedSql);
    }
}

unittest {
  auto builder = new CollationBuilder;
  assert(builder, "Could not create CollationBuilder");
}
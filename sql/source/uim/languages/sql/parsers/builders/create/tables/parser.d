module uim.languages.sql.parsers.builders.create.tables.parser;

import uim.languages.sql;

@safe:

// Builds index parser part of a PRIMARY KEY statement part of CREATE TABLE.
class IndexParserBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType(INDEX_PARSER)) {
            return "";
        }

        string mySql = "";
        foreach (myKey, myValie; parsedSql["sub_tree"]) {
            size_t oldSqlLength = mySql.length;
            mySql ~= this.buildReserved(myValue);
            mySql ~= this.buildConstant(myValue);
            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("CREATE TABLE primary key index parser subtree", myKey, myValue, "expr_type");
            }

            mySql ~= " ";
        }
        return subString(mySql, 0, -1);
    }

    protected string buildReserved(Json parsedSql) {
        auto builder = new ReservedBuilder();
        return builder.build(parsedSql);
    }

    protected string buildConstant(Json parsedSql) {
        auto builder = new ConstantBuilder();
        return builder.build(parsedSql);
    }
}

unittest {
  auto builder = new IndexParserBuilder;
  assert(builder, "Could not create IndexParserBuilder");
}
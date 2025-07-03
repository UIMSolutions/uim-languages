module langs.sql.parsers.builders.create.tables.constraint;

import langs.sql;

@safe:

// Builds the constraint statement part of CREATE TABLE.
class ConstraintBuilder : ISqlBuilder {

    string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("CONSTRAINT")) {
            return "";
        }
        string mySql = parsedSql["sub_tree"].isEmpty ? "" : this.buildConstant(
            parsedSql["sub_tree"]);
        return "CONSTRAINT" ~ (mySql.isEmpty ? "" : (" " ~ mySql));
    }

    protected string buildConstant(Json parsedSql) {
        auto myBuilder = new ConstantBuilder();
        return myBuilder.build(parsedSql);
    }
}

unittest {
  auto builder = new ConstraintBuilder;
  assert(builder, "Could not create ConstraintBuilder");
}
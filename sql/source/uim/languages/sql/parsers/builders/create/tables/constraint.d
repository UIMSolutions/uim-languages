module uim.languages.sql.parsers.builders.create.tables.constraint;

import uim.languages.sql;

@safe:

// Builds the constraint statement part of CREATE TABLE.
class ConstraintBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("CONSTRAINT")) {
            return "";
        }
        string mySql = parsedSql["sub_tree"].isEmpty ? "" : this.buildConstant(
            parsedSql["sub_tree"]);
        return "CONSTRAINT" ~ (mySql.isEmpty ? "" : (" " ~ mySql));
    }

    protected string buildConstant(Json parsedSql) {
        auto builder = new ConstantBuilder();
        return builder.build(parsedSql);
    }
}

unittest {
  auto builder = new ConstraintBuilder;
  assert(builder, "Could not create ConstraintBuilder");
}
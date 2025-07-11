module uim.languages.sql.parsers.builders.create.tables.defaulvalue;

import uim.languages.sql;

@safe:

// Builds the default value statement part of a column of a CREATE TABLE. 
class DefaultValueBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("DEF_VALUE")) {
            return "";
        }
        return parsedSql.baseExpression;
    }
}

unittest {
  auto builder = new DefaultValueBuilder;
  assert(builder, "Could not create DefaultValueBuilder");
}

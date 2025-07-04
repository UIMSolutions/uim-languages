module uim.languages.sql.parsers.builders.drop.schema;

import uim.languages.sql;

@safe:
// Builds the schema within the DROP statement. 
class SchemaBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("SCHEMA")) {
      return null;
    }

    return parsedSql.baseExpression;
  }
}

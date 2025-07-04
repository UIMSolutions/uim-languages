module uim.languages.sql.parsers.builders.show.engine;

import uim.languages.sql;

@safe:

// Builds the database within the SHOW statement. 
class EngineBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("ENGINE")) {
      return "";
    }

    return parsedSql.baseExpression;
  }
}

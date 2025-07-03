module uim.languages.sql.parsers.builders.position;

import uim.languages.sql;

@safe:

// Builds positions of the GROUP BY clause. 
class PositionBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("POSITION")) {
      return "";
    }
    
    return parsedSql.baseExpression;
  }
}

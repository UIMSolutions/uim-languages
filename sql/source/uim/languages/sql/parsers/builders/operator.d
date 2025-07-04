module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds operators.
class OperatorBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("OPERATOR")) {
      return "";
    }
    
    return parsedSql.baseExpression;
  }
}

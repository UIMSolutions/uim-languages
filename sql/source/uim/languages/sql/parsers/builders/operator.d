module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds operators.
class OperatorBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    return !parsedSql.isExpressionType("OPERATOR")
      ? null
      : parsedSql.baseExpression;
  }
}

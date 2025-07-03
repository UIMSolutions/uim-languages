module uim.languages.sql.parsers.builders.sign;

import uim.languages.sql;

@safe:

// Builds unary operators. 
class SignBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("SIGN")) {
      return null;
    }
    return parsedSql.baseExpression;
  }
}

module uim.languages.sql.parsers.helpers.json;

import uim.languages.sql;
@safe:

bool isExpressionType(Json parsedSql, string typeName) {
  return parsedSql.expressionType == typeName;
}

bool expressionType(Json parsedSql, string typeName) {
  return parsedSql.getString("expr_type");
}

string baseExpression(Json parsedSql) {
  return parsedSql.getString("base_expr");
}

Json createExpression(string type, string base) {
  Json expression = Json.emptyObject;
  expression.set("expr_type", type);
  expression.set("base_expr", base);
  return expression;
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.helpers.json;

import uim.languages.sql;
@safe:

bool anyExpressionType(Json parsedSql, string[] typeNames) {
  return typeNames.any!(name => parsedSql.isExpressionType(name));
}

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

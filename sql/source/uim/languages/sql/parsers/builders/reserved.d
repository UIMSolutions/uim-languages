module uim.languages.sql.parsers.builders.reserved;

import uim.languages.sql;

@safe:

// Builds reserved keywords. 
class ReservedBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    return !isReserved(parsedSql)
    ? null
    : parsedSql.baseExpression;
  }

  bool isReserved(Json parsedSql) {
    return parsedSql.isExpressionType("RESERVED");
  }
}

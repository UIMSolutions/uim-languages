module uim.languages.sql.parsers.builders.reserved;

import uim.languages.sql;

@safe:

// Builds reserved keywords. 
class ReservedBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!this.isReserved(parsedSql)) { return ""; }

    return parsedSql.baseExpression;
  }

  auto isReserved(Json parsedSql) {
    return parsedSql.isExpressionType("RESERVED");
  }
}

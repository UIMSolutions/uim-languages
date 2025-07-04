/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
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

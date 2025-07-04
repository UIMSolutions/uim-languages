/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.position;

import uim.languages.sql;

@safe:

// Builds positions of the GROUP BY clause. 
class PositionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    return !parsedSql.isExpressionType("POSITION")
      ? null
      : parsedSql.baseExpression;
  }
}

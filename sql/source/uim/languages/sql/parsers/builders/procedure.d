/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.procedure;

import uim.languages.sql;

@safe:

// Builds the procedures within the SHOW statement. 
class ProcedureBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    return !parsedSql.isExpressionType("PROCEDURE")
      ? null
      : parsedSql.baseExpression;
  }
}

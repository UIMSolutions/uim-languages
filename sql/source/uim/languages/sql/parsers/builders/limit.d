/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds the LIMIT statement.
class LimitBuilder : ISqlBuilder {

  override string build(Json parsedSql) {
    string sql = parsedSql.getString("rowcount") ~
      (parsedSql.has("offset") 
        ? " OFFSET " ~ parsedSql.getString("offset") 
        : "");

    if (sql.isEmpty) {
      throw new UnableToCreateSQLException("LIMIT", "rowcount", parsedSql, "rowcount");
    }

    return "LIMIT " ~ sql;
  }
}

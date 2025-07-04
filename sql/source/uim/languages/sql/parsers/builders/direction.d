/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.direction;

import uim.languages.sql;

@safe:
// Builds direction (e.g. of the order-by clause).
class DirectionBuilder : IBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isSet("direction") || parsedSql["direction"].isEmpty) {
      return "";
    }
    return " " ~ parsedSql["direction"].get!string;
  }
}

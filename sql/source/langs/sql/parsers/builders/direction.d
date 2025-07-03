module uim.languages.sql.parsers.builders.direction;

import uim.languages.sql;

@safe:
// Builds direction (e.g. of the order-by clause).
class DirectionBuilder : IBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isSet("direction") || parsedSql["direction"].isEmpty) {
      return "";
    }
    return " " ~ parsedSql["direction"].get!string;
  }
}

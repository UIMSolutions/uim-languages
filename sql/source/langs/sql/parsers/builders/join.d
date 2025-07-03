module uim.languages.sql.parsers.builders.join;

import uim.languages.sql;

@safe:
// Builds the JOIN statement parts (within FROM).
class JoinBuilder {

  string build(Json parsedSql) {
    if (parsedSql == "CROSS") {
      return ", ";
    }
    if (parsedSql == "JOIN") {
      return " INNER JOIN ";
    }
    if (parsedSql == "LEFT") {
      return " LEFT JOIN ";
    }
    if (parsedSql == "RIGHT") {
      return " RIGHT JOIN ";
    }
    if (parsedSql == "STRAIGHT_JOIN") {
      return " STRAIGHT_JOIN ";
    }
    // TODO: add more
    throw new UnsupportedFeatureException(parsedSql);
  }
}

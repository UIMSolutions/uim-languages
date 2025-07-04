module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds the LIMIT statement.
class LimitBuilder : ISqlBuilder {

  string build(Json parsedSql) {
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

module langs.sql.parsers.builders.index.columns;

import langs.sql;

@safe:

// Builds the column entries of the column-list parts of CREATE TABLE.
class IndexColumnBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("INDEX_COLUMN")) {
      return null;
    }

    string mySql = parsedSql["name"];
   mySql ~= this.buildLength(parsedSql["length"]);
   mySql ~= this.buildDirection(parsedSql["dir"]);
    return mySql;
  }

  protected string buildLength(Json parsedSql) {
    return (parsedSql.isEmpty ? "" : ("(" ~ parsedSql ~ ")"));
  }

  protected string buildDirection(Json parsedSql) {
    return (parsedSql.isEmpty ? "" : (" " ~ parsedSql));
  }
}

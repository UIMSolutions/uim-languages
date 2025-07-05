/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.statements.show;

import uim.languages.sql;

@safe:

// Builds the SHOW statement.
class ShowStatementBuilder : DSqlStatementBuilder {

  override string build(Json parsedSql) {
    string mySql = this.buildShow(parsedSql);
    if (parsedSql.isSet("WHERE")) {
      mySql ~= " " ~ this.buildWhere(parsedSql["WHERE"]);
    }
    return mySql;
  }

  protected string buildWhere(Json parsedSql) {
    auto builder = new WhereBuilder();
    return builder.build(parsedSql);
  }

  protected string buildShow(Json parsedSql) {
    auto builder = new ShowBuilder();
    return builder.build(parsedSql);
  }
}

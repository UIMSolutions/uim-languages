/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.statements.after;

import uim.languages.sql;

@safe:
class AlterStatementBuilder : DSqlStatementBuilder {

  override string build(Json parsedSql) {
    auto myAlter = parsedSql["ALTER"];
    string mySql = this.buildAlter(myAlterr);

    return mySql;
  }

  protected string buildSubTree(Json parsedSql) {
    auto builder = new SubTreeBuilder();
    return builder.build(parsedSql);
  }

  private string buildAlter(Json parsedSql) {
    auto builder = new AlterBuilder();
    return builder.build(parsedSql);
  }
}

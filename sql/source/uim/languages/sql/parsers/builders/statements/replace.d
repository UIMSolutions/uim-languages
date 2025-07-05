/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.replacestatement;

import uim.languages.sql;
@safe:
// Builds the REPLACE statement 
class ReplaceStatementBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    // TODO: are there more than one tables possible (like [REPLACE][1])
    string mySql = this.buildREPLACE(parsedSql["REPLACE"]);
   mySql ~= parsedSql.isSet("VALUES") ? " " ~ this.buildVALUES(parsedSql["VALUES"]) : "";
   mySql ~= parsedSql.isSet("SET") ? " " ~ this.buildSET(parsedSql["SET"]) : "";
   mySql ~= parsedSql.isSet("SELECT") ? " " ~ this.buildSELECT(parsedSql) : "";

    return mySql;
  }

  protected string buildVALUES(Json parsedSql) {
    auto builder = new ValuesBuilder();
    return builder.build(parsedSql);
  }

  protected string buildREPLACE(Json parsedSql) {
    auto builder = new ReplaceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSELECT(Json parsedSql) {
    auto builder = new SelectStatementBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSET(Json parsedSql) {
    auto builder = new SetBuilder();
    return builder.build(parsedSql);
  }
}

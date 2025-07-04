/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.create.index;

import uim.languages.sql;

@safe:
// Builds the CREATE INDEX statement
class CreateIndexBuilder : DSqlBuilder {
  override string build(Json parsedSql) {
    string mySql = parsedSql["name"].get!string;
    mySql ~= " " ~ this.buildIndexType(parsedSql);
    mySql = mySql.strip;
    mySql ~= " " ~ this.buildIndexTable(parsedSql);
    mySql = mySql.strip;
    mySql ~= this.buildIndexOptions(parsedSql);
    return mySql.strip;
  }

  protected string buildIndexType(Json parsedSql) {
    auto myBuilder = new CreateIndexTypeBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildIndexTable(Json parsedSql) {
    auto myBuilder = new CreateIndexTableBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildIndexOptions(Json parsedSql) {
    auto myBuilder = new CreateIndexOptionsBuilder();
    return myBuilder.build(parsedSql);
  }

}

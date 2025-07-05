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
    string sql = parsedSql.getString("name");
    sql ~= " " ~ this.buildIndexType(parsedSql);
    sql = sql.strip;
    sql ~= " " ~ this.buildIndexTable(parsedSql);
    sql = sql.strip;
    sql ~= this.buildIndexOptions(parsedSql);
    return sql.strip;
  }

  protected string buildIndexType(Json parsedSql) {
    auto builder = new CreateIndexTypeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexTable(Json parsedSql) {
    auto builder = new CreateIndexTableBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexOptions(Json parsedSql) {
    auto builder = new CreateIndexOptionsBuilder();
    return builder.build(parsedSql);
  }
}

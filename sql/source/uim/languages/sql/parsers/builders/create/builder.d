/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.create.builder;

import uim.languages.sql;

@safe:
// Builds the CREATE statement
class DCreateSqlBuilder : DSqlBuilder {
  this() {
  }

  override string build(Json parsedSql) {
    if (!parsedSql.isObject) {
      return null;
    }

    auto create = parsedSql["CREATE"];
    string sql = this.buildSubTree(create);

    if (create.isExpressionType("TABLE")
      || create.isExpressionType("TEMPORARY_TABLE")) {
     sql ~= " " ~ this.buildCreateTable(parsedSql["TABLE"]);
    }
    if (create.isExpressionType("INDEX")) {
     sql ~= " " ~ this.buildCreateIndex(parsedSql["INDEX"]);
    }

    // TODO: add more expr_types here (like VIEW), if available in parser output
    return "CREATE " ~ sql;
  }

  protected string buildCreateTable(Json parsedSql) {
    auto builder = new CreateTableBuilder();
    return builder.build(parsedSql);
  }

  protected string buildCreateIndex(Json parsedSql) {
    auto builder = new CreateIndexBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSubTree(Json parsedSql) {
    auto builder = new SubTreeBuilder();
    return builder.build(parsedSql);
  }
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.selects.selectexpression;

import uim.languages.sql;

@safe:

// Builds simple expressions within a SELECT statement.
class SelectExpressionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    return !parsedSql.isExpressionType("EXPRESSION")
      ? ""
      : buildSubTree(parsedSql, " ") ~ buildAlias(parsedSql);;
  }

  protected string buildSubTree(parsedSql, string delim) {
    auto myBuilder = new SubTreeBuilder();
    return myBuilder.build(parsedSql, delim);
  }

  protected string buildAlias(Json parsedSql) {
    auto myBuilder = new AliasBuilder();
    return myBuilder.build(parsedSql);
  }
}

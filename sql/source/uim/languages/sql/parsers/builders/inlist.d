/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.inlist;

import uim.languages.sql;

@safe:

// Builds lists of values for the IN statement.
class InListBuilder : DSqlBuilder {

  protected string buildSubTree(parsedSql, string delim) {
    auto builder = new SubTreeBuilder();
    return builder.build(parsedSql, delim);
  }

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("IN_LIST")) {
      return null;
    }
    
    string mySql = this.buildSubTree(parsedSql, ", ");
    return "(" ~ mySql ~ ")";
  }
}

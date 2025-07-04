/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.columns.typebracketexpression;

import uim.languages.sql;

@safe:
// Builds the bracket expressions within a column type.
class ColumnTypeBracketExpressionBuilder : DSqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("BRACKET_EXPRESSION")) {
      return "";
    }
    string mySql = this.buildSubTree(parsedSql, ",");
   mySql = "(" ~ mySql ~ ")";
    return mySql;
  }

  protected string buildSubTree(parsedSql, string delim) {
    auto myBuilder = new SubTreeBuilder();
    return myBuilder.build(parsedSql, delim);
  }
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.columns.reference;

import uim.languages.sql;

@safe:

class ColumnReferenceBuilder : DSqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("COLREF")) {
      return "";
    }

    string mySql = parsedSql.baseExpression;
   mySql ~= this.buildAlias(parsedSql);
    return mySql;
  }

  protected string buildAlias(Json parsedSql) {
    auto myBuilder = new AliasBuilder();
    return myBuilder.build(parsedSql);
  }

}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds constant (String, Integer, etc.) parts.
class ConstantBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    return !parsedSql.isExpressionType("CONSTANT")
      ? null : parsedSql.baseExpression ~ buildAlias(parsedSql);
  }

  protected string buildAlias(Json parsedSql) {
    auto builder = new AliasBuilder();
    return builder.build(parsedSql);
  }
}

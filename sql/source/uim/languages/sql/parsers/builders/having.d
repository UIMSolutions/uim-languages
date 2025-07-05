/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.having;

import uim.languages.sql;

@safe:

/**
 * Builds the HAVING part.
 * This class : the builder for the HAVING part. 
 */
class HavingBuilder : WhereBuilder {

  override string build(Json parsedSql) {
    string mySql = "HAVING ";
    foreach (key, value; parsedSql) {
      mySql ~= buildKeyValue(key, value);
    }
    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string key, Json value) {
    string sql;

    sql ~= buildAliasReference(value);
    sql ~= buildOperator(value);
    sql ~= buildConstant(value);
    sql ~= buildColRef(value);
    sql ~= buildSubQuery(value);
    sql ~= buildInList(value);
    sql ~= buildFunction(value);
    sql ~= buildHavingExpression(value);
    sql ~= buildHavingBracketExpression(value);
    sql ~= buildUserVariable(value);

    if (sql.isEmpty) {
      throw new UnableToCreateSQLException("HAVING", key, value, "expr_type");
    }

    return sql ~ " ";
  }

  protected string buildAliasReference(Json parsedSql) {
    auto myBuilder = new AliasReferenceBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildHavingExpression(Json parsedSql) {
    auto myBuilder = new HavingExpressionBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildHavingBracketExpression(Json parsedSql) {
    auto myBuilder = new HavingBracketExpressionBuilder();
    return myBuilder.build(parsedSql);
  }
}

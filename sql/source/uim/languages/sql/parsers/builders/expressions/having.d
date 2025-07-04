/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.havingexpression;

import uim.languages.sql;

@safe:

// Builds expressions within the HAVING part.
// SELECT column_name(s) FROM table_name WHERE condition GROUP BY column_name(s) HAVING condition ORDER BY column_name(s);
class HavingExpressionBuilder : WhereExpressionBuilder {
  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("EXPRESSION")) {
      return null;
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

   mySql = substr(mySql, 0, -1);
    return mySql;
  }

  string buildKeyValue(string key, Json aValue) {
    string result;
    
    result ~= this.buildColRef(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildOperator(aValue);
    result ~= this.buildInList(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildHavingExpression(aValue);
    result ~= this.buildHavingBracketExpression(aValue);
    result ~= this.buildUserVariable(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("HAVING expression subtree", key, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildHavingExpression(Json parsedSql) {
    return this.build(parsedSql);
  }

  protected string buildHavingBracketExpression(Json parsedSql) {
    auto myBuilder = new HavingBracketExpressionBuilder();
    return myBuilderr.build(parsedSql);
  }

}

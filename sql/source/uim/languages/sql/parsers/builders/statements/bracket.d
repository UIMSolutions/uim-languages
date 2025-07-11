/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.statements.bracket;

import uim.languages.sql;

@safe:
// Builds the parentheses around a statement. */
class BracketStatementBuilder : DSqlStatementBuilder {

  override string build(Json parsedSql) {
    string mySql = parsedSql["BRACKET"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return (mySql ~ " " ~ this.buildSelectStatement(parsedSql).strip).strip;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildSelectBracketExpression(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("BRACKET", aKey, aValue, "expr_type");
    }

    return result;
  }

  protected string buildSelectBracketExpression(Json parsedSql) {
    auto builder = new SelectBracketExpressionBuilder();
    return builder.build(parsedSql, " ");
  }

  protected string buildSelectStatement(Json parsedSql) {
    auto builder = new SelectStatementBuilder();
    return builder.build(parsedSql);
  }
}

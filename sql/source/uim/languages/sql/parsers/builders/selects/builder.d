/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.selects.builder;

import uim.languages.sql;

@safe:

// Builds the SELECT statement from the [SELECT] field. 
class SelectBuilder : DSqlBuilder {

  /**
     * Returns a well-formatted delimiter string. If you don"t need nice SQL,
     * you could simply return parsedSql["delim"].
     * 
     * @param Json parsedSql The part of the output array, which contains the current expression.
     * @return a string, which is added right after the expression
     */
  protected auto getDelimiter(Json parsedSql) {
    return (!parsedSql.isSet("delim") || parsedSql["delim"].isEmpty ? "" : (
        parsedSql["delim"]) ~ " ").strip;
  }

  override string build(Json parsedSql) {
    string mySql = "";

    foreach (myKey, myValue; parsedSql) {
      size_t oldSqlLength = mySql.length;
      mySql ~= this.buildColRef(myValue);
      mySql ~= this.buildSelectBracketExpression(myValue);
      mySql ~= this.buildSelectExpression(myValue);
      mySql ~= this.buildFunction(myValue);
      mySql ~= this.buildConstant(myValue);
      mySql ~= this.buildReserved(myValue);

      if (oldSqlLength == mySql.length) { // No change
        throw new UnableToCreateSQLException("SELECT", myKey, myValue, "expr_type");
      }

      mySql ~= this.getDelimiter(myValue);
    }
    return "SELECT " ~ mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    return result;
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildFunction(Json parsedSql) {
    auto builder = new FunctionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSelectExpression(Json parsedSql) {
    auto builder = new SelectExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSelectBracketExpression(Json parsedSql) {
    auto builder = new SelectBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

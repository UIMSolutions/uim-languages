/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.subtree;

import uim.languages.sql;

@safe:

// Builds the statements for [sub_tree] fields.
class SubTreeBuilder : DSqlBuilder {

  override string build(Json parsedSql, string delim = " ") {
    if (parsedSql["sub_tree"].isEmpty) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0,  -delim.length);
  }

  string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildColRef(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildOperator(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildInList(aValue);
    result ~= this.buildSubQuery(aValue);
    result ~= this.buildSelectBracketExpression(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildQuery(aValue);
    result ~= this.buildUserVariable(aValue);

    string mySign = this.buildSign(aValue);
    result ~= mySign;

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("expression subtree", aKey, aValue.toString, "expr_type");
    }

    // We don"t need whitespace between a sign and the following part.
    if (mySign.isEmpty) {
      result ~= delim;
    }

    return result;
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildFunction(Json parsedSql) {
    auto builder = new FunctionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildOperator(Json parsedSql) {
    auto builder = new OperatorBuilder();
    return builder.build(parsedSql);
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildInList(Json parsedSql) {
    auto builder = new InListBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSubQuery(Json parsedSql) {
    auto builder = new SubQueryBuilder();
    return builder.build(parsedSql);
  }

  protected string buildQuery(Json parsedSql) {
    auto builder = new QueryBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSelectBracketExpression(Json parsedSql) {
    auto builder = new SelectBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildUserVariable(Json parsedSql) {
    auto builder = new UserVariableBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSign(Json parsedSql) {
    auto builder = new SignBuilder();
    return builder.build(parsedSql);
  }
}

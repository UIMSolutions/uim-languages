/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.record;

import uim.languages.sql;

@safe:

// Builds the records within the INSERT statement. 
class RecordBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("RECORD")) {
      return parsedSql.get("base_expr", "");
    }

    string sql = parsedSql["data"].byKeyValue
      .map(kv => buildKeyValue(kv.key, kv.value))
      .join;

    sql = substr(sql, 0, -2);
    return "(" ~ sql ~ ")";
  }

  protected string buildKeyValue(string key, Json value) {
    string sql;

    sql ~= this.buildConstant(value);
    sql ~= this.buildFunction(value);
    sql ~= this.buildOperator(value);
    sql ~= this.buildColRef(value);

    if (sql.isEmpty) { // No change
      throw new UnableToCreateSQLException(expressionType("RECORD"), key, value, "expr_type");
    }

    return sql ~ ", ";
  }

  protected string buildOperator(Json parsedSql) {
    auto myBuilder = new OperatorBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildFunction(Json parsedSql) {
    auto myBuilder = new FunctionBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildConstant(Json parsedSql) {
    auto myBuilder = new ConstantBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildColRef(Json parsedSql) {
    auto myBuilder = new ColumnReferenceBuilder();
    return myBuilder.build(parsedSql);
  }
}

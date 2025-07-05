module uim.languages.sql.parsers.builders.orderby.builder;

import uim.languages.sql;

@safe:

// Builds the ORDERBY clause. 
class OrderByBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string result = parsedSql.myKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return "ORDER BY " ~ subString(result, 0, -2);
  }

  string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildAlias(aValue);
    result ~= this.buildColRef(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildExpression(aValue);
    result ~= this.buildBracketExpression(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildPosition(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("ORDER", aKey, aValue, "expr_type");
    }

    result ~= ", ";
    return result;
  }

  protected string buildFunction(Json parsedSql) {
    auto builder = new OrderByFunctionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new OrderByReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new OrderByColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildAlias(Json parsedSql) {
    auto builder = new OrderByAliasBuilder();
    return builder.build(parsedSql);
  }

  protected string buildExpression(Json parsedSql) {
    auto builder = new OrderByExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildBracketExpression(Json parsedSql) {
    auto builder = new OrderByBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildPosition(Json parsedSql) {
    auto builder = new OrderByPositionBuilder();
    return builder.build(parsedSql);
  }
}

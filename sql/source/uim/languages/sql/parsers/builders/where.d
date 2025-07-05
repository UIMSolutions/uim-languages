module uim.languages.sql.parsers.builders.where;

import uim.languages.sql;

@safe:

// Builds the WHERE part.
class WhereBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    auto mySql = "WHERE ";
    parsedSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join(" ");

    return mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildOperator(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildColRef(aValue);
    result ~= this.buildSubQuery(aValue);
    result ~= this.buildInList(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildWhereExpression(aValue);
    result ~= this.buildWhereBracketExpression(aValue);
    result ~= this.buildUserVariable(aValue);
    result ~= this.buildReserved(aValue);

    if (result.isEmpty) {
      throw new UnableToCreateSQLException("WHERE", aKey, aValue, "expr_type");
    }

    return result;
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildOperator(Json parsedSql) {
    auto builder = new OperatorBuilder();
    return builder.build(parsedSql);
  }

  protected string buildFunction(Json parsedSql) {
    auto builder = new FunctionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSubQuery(Json parsedSql) {
    auto builder = new SubQueryBuilder();
    return builder.build(parsedSql);
  }

  protected string buildInList(Json parsedSql) {
    auto builder = new InListBuilder();
    return builder.build(parsedSql);
  }

  protected string buildWhereExpression(Json parsedSql) {
    auto builder = new WhereExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildWhereBracketExpression(Json parsedSql) {
    auto builder = new WhereBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildUserVariable(Json parsedSql) {
    auto builder = new UserVariableBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

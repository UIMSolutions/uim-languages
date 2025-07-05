module uim.languages.sql.parsers.builders.whereexpression;

import uim.languages.sql;

@safe:

// Builds expressions within the WHERE part.
class WhereExpressionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("EXPRESSION")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

   mySql = subString(mySql, 0, -1);
    return mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildColRef(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildOperator(aValue);
    result ~= this.buildInList(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildWhereExpression(aValue);
    result ~= this.buildWhereBracketExpression(aValue);
    result ~= this.buildUserVariable(aValue);
    result ~= this.buildSubQuery(aValue);
    result ~= this.buildReserved(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("WHERE expression subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
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

  protected string buildInList(Json parsedSql) {
    auto builder = new InListBuilder();
    return builder.build(parsedSql);
  }

  protected string buildWhereExpression(Json parsedSql) {
    return this.build(parsedSql);
  }

  protected string buildWhereBracketExpression(Json parsedSql) {
    auto builder = new WhereBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildUserVariable(Json parsedSql) {
    auto builder = new UserVariableBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSubQuery(Json parsedSql) {
    auto builder = new SubQueryBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

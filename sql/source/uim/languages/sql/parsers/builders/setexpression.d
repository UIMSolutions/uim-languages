module uim.languages.sql.parsers.builders.setexpression;

import uim.languages.sql;

@safe:

// Builds the SET part of the INSERT statement. */
class SetExpressionBuilder : DSqlBuilder {

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
    string myDelim = " ";
    string result;
    
    result ~= this.buildColRef(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildOperator(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildBracketExpression(aValue);

    // we don"t need whitespace between the sign and 
    // the following part
    if (this.buildSign(aValue) != "") {
     myDelim = "";
    }

    result ~= this.buildSign(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("SET expression subtree", aKey, aValue, "expr_type");
    }

    result ~= myDelim;
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

  protected string buildBracketExpression(Json parsedSql) {
    auto builder = new SelectBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected austringto buildSign(Json parsedSql) {
    auto builder = new SignBuilder();
    return builder.build(parsedSql);
  }
}

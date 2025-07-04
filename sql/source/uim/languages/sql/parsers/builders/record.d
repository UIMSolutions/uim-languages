module uim.languages.sql.parsers.builders.record;

import uim.languages.sql;

@safe:

// Builds the records within the INSERT statement. 
class RecordBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("RECORD")) {
      return parsedSql.get("base_expr", "");
    }

    string mySql = parsedSql["data"].byKeyValue
      .map(kv => buildKeyValue(kv.key, kv.value))
      .join;

   mySql = substr(mySql, 0, -2);
    return "(" ~ mySql ~ ")";
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    
    result ~= this.buildConstant(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildOperator(aValue);
    result ~= this.buildColRef(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException(expressionType("RECORD"), aKey, aValue, "expr_type");
    }

    result ~= ", ";
    return result;
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

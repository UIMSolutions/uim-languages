module uim.languages.sql.parsers.builders.replace;

import uim.languages.sql;

@safe:

// Builds the [REPLACE] statement part. 
class ReplaceBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = parsedSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return "REPLACE " ~ subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildTable(aValue);
    result ~= this.buildSubQuery(aValue);
    result ~= this.buildColumnList(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildBracketExpression(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("REPLACE", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildTable(Json parsedSql) {
    auto builder = new TableBuilder();
    return builder.build(parsedSql, 0);
  }

  protected string buildSubQuery(Json parsedSql) {
    auto builder = new SubQueryBuilder();
    return builder.build(parsedSql, 0);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildBracketExpression(Json parsedSql) {
    auto builder = new SelectBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildColumnList(Json parsedSql) {
    auto builder = new ReplaceColumnListBuilder();
    return builder.build(parsedSql, 0);
  }
}

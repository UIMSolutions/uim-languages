module langs.sql.parsers.builders.replace;

import langs.sql;

@safe:

// Builds the [REPLACE] statement part. 
class ReplaceBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    string mySql = parsedSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return "REPLACE " ~ substr(mySql, 0, -1);
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
    auto myBuilder = new TableBuilder();
    return myBuilder.build(parsedSql, 0);
  }

  protected string buildSubQuery(Json parsedSql) {
    auto myBuilder = new SubQueryBuilder();
    return myBuilder.build(parsedSql, 0);
  }

  protected string buildReserved(Json parsedSql) {
    auto myBuilder = new ReservedBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildBracketExpression(Json parsedSql) {
    auto myBuilder = new SelectBracketExpressionBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildColumnList(Json parsedSql) {
    auto myBuilder = new ReplaceColumnListBuilder();
    return myBuilder.build(parsedSql, 0);
  }
}

module uim.languages.sql.parsers.builders.groupby.builder;

import uim.languages.sql;

@safe:

// Builder for the GROUP-BY clause. 
class GroupByBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = parsedSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

   mySql = subString(mySql, 0, -2);
    return "GROUP BY " ~ mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildColRef(aValue);
    result ~= this.buildPosition(aValue);
    result ~= this.buildFunction(aValue);
    result ~= this.buildGroupByExpression(aValue);
    result ~= this.buildGroupByAlias(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("GROUP", aKey, aValue, "expr_type");
    }

    result ~= ", ";
    return result;
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildPosition(Json parsedSql) {
    auto builder = new PositionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildFunction(Json parsedSql) {
    auto builder = new FunctionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildGroupByAlias(Json parsedSql) {
    auto builder = new GroupByAliasBuilder();
    return builder.build(parsedSql);
  }

  protected string buildGroupByExpression(Json parsedSql) {
    auto builder = new GroupByExpressionBuilder();
    return builder.build(parsedSql);
  }
}

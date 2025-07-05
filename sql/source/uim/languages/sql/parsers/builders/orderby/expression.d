module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:
// Builds expressions within the ORDER-BY part. It must contain the direction.
class OrderByExpressionBuilder : WhereExpressionBuilder {

  override string build(Json parsedSql) {
    string result = super.build(parsedSql);
    if (!result.isEmpty) {
      result ~= this.buildDirection(parsedSql);
    }
    return result;
  }

  protected string buildDirection(Json parsedSql) {
    auto auto builder = new DirectionBuilder();
    return builder.build(parsedSql);
  }

}

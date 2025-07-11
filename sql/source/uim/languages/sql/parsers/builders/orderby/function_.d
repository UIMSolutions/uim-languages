module uim.languages.sql.parsers.builders.orderby.function_;

import uim.languages.sql;

@safe:
// Builds functions within the ORDER-BY part. 
class OrderByFunctionBuilder : FunctionBuilder {

  override string build(Json parsedSql) {
    auto mySql = super.build(parsedSql);
    if (!mySql.isEmpty) {
     mySql ~= this.buildDirection(parsedSql);
    }
    return mySql;
  }

  protected string buildDirection(Json parsedSql) {
    auto builder = new DirectionBuilder();
    return builder.build(parsedSql);
  }
}

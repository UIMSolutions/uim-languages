module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:
// Builds reserved keywords within the ORDER-BY part. 
class OrderByReservedBuilder : ReservedBuilder {

  override string build(Json parsedSql) {
    string mySql = super.build(parsedSql);
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

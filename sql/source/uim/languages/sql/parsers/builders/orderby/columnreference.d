module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:
// Builds column references within the ORDER-BY part.
class OrderByColumnReferenceBuilder : ColumnReferenceBuilder {

  override string build(Json parsedSql) {
    string result = super.build(parsedSql);
    if (!result.isEmpty) {
      result ~= this.buildDirection(parsedSql);
    }
    return result;
  }

  protected string buildDirection(Json parsedSql) {
    auto builder = new DirectionBuilder();
    return builder.build(parsedSql);
  }
}

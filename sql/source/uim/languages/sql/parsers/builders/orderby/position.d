module uim.languages.sql.parsers.builders.orderby.position;

import uim.languages.sql;

@safe:

// Builds positions of the GROUP BY clause. 
class OrderByPositionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("POSITION")) {
      return "";
    }
    return parsedSql.baseExpression ~ this.buildDirection(parsedSql);
  }

  protected string buildDirection(Json parsedSql) {
    auto builder = new DirectionBuilder();
    return builder.build(parsedSql);
  }
}

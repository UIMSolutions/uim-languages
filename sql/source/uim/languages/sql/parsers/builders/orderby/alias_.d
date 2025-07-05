module uim.languages.sql.parsers.builders.orderby.alias_;

import uim.languages.sql;

@safe:

// Builds an alias within an ORDER-BY clause.
class OrderByAliasBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("ALIAS")) {
      return null;
    }
    return parsedSql.baseExpression ~ this.buildDirection(parsedSql);
  }

  protected string buildDirection(Json parsedSql) {
    auto builder = new DirectionBuilder();
    return builder.build(parsedSql);
  }
}

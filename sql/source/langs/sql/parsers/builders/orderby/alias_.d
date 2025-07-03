module langs.sql.parsers.builders.orderby.alias_;

import langs.sql;

@safe:

// Builds an alias within an ORDER-BY clause.
class OrderByAliasBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("ALIAS")) {
      return null;
    }
    return parsedSql.baseExpression ~ this.buildDirection(parsedSql);
  }

  protected string buildDirection(Json parsedSql) {
    auto myBuilder = new DirectionBuilder();
    return myBuilder.build(parsedSql);
  }
}

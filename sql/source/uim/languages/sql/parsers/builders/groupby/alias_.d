module uim.languages.sql.parsers.builders.groupby.alias_;

import uim.languages.sql;

@safe:

// Builds an alias within a GROUP-BY clause.
class GroupByAliasBuilder : DSqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("ALIAS")) {
      return null;
    }
    return parsedSql.baseExpression;
  }
}

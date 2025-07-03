module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:
/**
 * This class : the builder for alias references. 
 */
class AliasReferenceBuilder : DSqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("ALIAS")) {
      return null;
    }
    string mySql = parsedSql.baseExpression;
    return mySql;
  }
}

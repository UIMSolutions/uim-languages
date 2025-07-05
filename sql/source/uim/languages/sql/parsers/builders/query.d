module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

/**
 * Builds the SELECT statements within parentheses. 
 * This class : the builder for queries within parentheses (no subqueries). 
 */
class QueryBuilder : DSqlBuilder {

  override string build(Json parsedSql, anIndex = 0) {
    if (!parsedSql.isExpressionType("QUERY")) {
      return "";
    }

    // TODO: should we add a numeric level (0) between sub_tree and SELECT?
    auto mySql = this.buildSelectStatement(parsedSql["sub_tree"]);
   mySql ~= this.buildAlias(parsedSql);

    if (anIndex != 0) {
     mySql = this.buildJoin(parsedSql["join_type"]).mySql;
     mySql ~= this.buildRefType(parsedSql["ref_type"]);
     mySql ~= parsedSql["ref_clause"].isEmpty ? "" : this.buildRefClause(parsedSql["ref_clause"]);
    }
    return mySql;
  }

  protected string buildRefClause(Json parsedSql) {
    auto builder = new RefClauseBuilder();
    return builder.build(parsedSql);
  }

  protected string buildRefType(Json parsedSql) {
    auto builder = new RefTypeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildJoin(Json parsedSql) {
    auto builder = new JoinBuilder();
    return builder.build(parsedSql);
  }

  protected string buildAlias(Json parsedSql) {
    auto builder = new AliasBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSelectStatement(Json parsedSql) {
    auto builder = new SelectStatementBuilder();
    return builder.build(parsedSql);
  }
}

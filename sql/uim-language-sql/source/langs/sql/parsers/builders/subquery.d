module langs.sql.parsers.builders.subquery;

import langs.sql;

@safe:

// Builds the statements for sub-queries. 
class SubQueryBuilder : ISqlBuilder {

  string build(Json parsedSql, size_t index = 0) {
    if (!parsedSql.isExpressionType("SUBQUERY")) {
      return "";
    }

    // TODO: should we add a numeric level (0) between sub_tree and SELECT?
    string mySql = this.buildSelectStatement(parsedSql["sub_tree"]);
   mySql = "(" ~ mySql ~ ")";
   mySql ~= this.buildAlias(parsedSql);

    if (index != 0) {
     mySql = this.buildJoin(parsedSql["join_type"]) ~ mySql;
     mySql ~= this.buildRefType(parsedSql["ref_type"]);
     mySql ~= parsedSql["ref_clause"].isEmpty ? "" : this.buildRefClause(parsedSql["ref_clause"]);
    }
    
    return mySql;
  }
  protected string buildRefClause(Json parsedSql) {
    auto myBuilder = new RefClauseBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildRefType(Json parsedSql) {
    auto myBuilder = new RefTypeBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildJoin(Json parsedSql) {
    auto myBuilder = new JoinBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildAlias(Json parsedSql) {
    auto myBuilder = new AliasBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildSelectStatement(Json parsedSql) {
    auto myBuilder = new SelectStatementBuilder();
    return myBuilder.build(parsedSql);
  }
}

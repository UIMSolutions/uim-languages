module uim.languages.sql.parsers.builders.table;

import uim.languages.sql;

@safe:

// Builds the table name/join options.
class TableBuilder : DSqlBuilder {

  override string build(Json parsedSql, size_t index = 0) {
    if (!parsedSql.isExpressionType("TABLE")) {
      return "";
    }

    // Main
    auto mySql = parsedSql["table"];
   mySql ~= this.buildAlias(parsedSql);
   mySql ~= this.buildIndexHintList(parsedSql);

    if (index > 0) {
     mySql = this.buildJoin(parsedSql["join_type"]) ~ mySql;
     mySql ~= this.buildRefType(parsedSql["ref_type"]);
     mySql ~= parsedSql["ref_clause"].isEmpty ? "" : this.buildRefClause(parsedSql["ref_clause"]);
    }

    return mySql;
  }
  protected string buildAlias(Json parsedSql) {
    AliasBuilder builder = new AliasBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexHintList(Json parsedSql) {
    IndexHintListBuilder builder = new IndexHintListBuilder();
    return builder.build(parsedSql);
  }

  protected string buildJoin(Json parsedSql) {
    JoinBuilder builder = new JoinBuilder();
    return builder.build(parsedSql);
  }

  protected string buildRefType(Json parsedSql) {
    auto builder = new RefTypeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildRefClause(Json parsedSql) {
    auto builder = new RefClauseBuilder();
    return builder.build(parsedSql);
  }

}

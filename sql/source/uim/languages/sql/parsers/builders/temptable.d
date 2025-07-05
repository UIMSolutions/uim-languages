module source.uim.languages.sql.parsers.builders.temptable;

import uim.languages.sql;

@safe:

// Builds the temporary table name/join options. 
class TempTableBuilder : DSqlBuilder {

  override string build(Json parsedSql, size_t index = 0) {
    if (!parsedSql.isExpressionType("TEMPORARY_TABLE")) {
      return "";
    }

    auto mySql = parsedSql["table"];
   mySql ~= this.buildAlias(parsedSql);

    if (index != 0) {
     mySql = this.buildJoin(parsedSql["join_type"]) ~ mySql;
     mySql ~= this.buildRefType(parsedSql["ref_type"]);
     mySql ~= parsedSql["ref_clause"].isEmpty ? "" : this.buildRefClause(parsedSql["ref_clause"]);
    }
    return mySql;
  }

  protected string buildAlias(Json parsedSql) {
    auto builder = new AliasBuilder();
    return builder.build(parsedSql);
  }

  protected string buildJoin(Json parsedSql) {
    auto builder = new JoinBuilder();
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

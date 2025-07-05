module uim.languages.sql.parsers.builders.selects.statement;

// Builds the SELECT statement 
class SelectStatementBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = "";
    if (parsedSql.isSet("SELECT")) {
     mySql ~= this.buildSELECT(parsedSql["SELECT"]);
    }
    if (parsedSql.isSet("FROM")) {
     mySql ~= " " ~ this.buildFROM(parsedSql["FROM"]);
    }
    if (parsedSql.isSet("WHERE")) {
     mySql ~= " " ~ this.buildWhere(parsedSql["WHERE"]);
    }
    if (parsedSql.isSet("GROUP")) {
     mySql ~= " " ~ this.buildGROUP(parsedSql["GROUP"]);
    }
    if (parsedSql.isSet("HAVING")) {
     mySql ~= " " ~ this.buildHAVING(parsedSql["HAVING"]);
    }
    if (parsedSql.isSet("ORDER")) {
     mySql ~= " " ~ this.buildORDER(parsedSql["ORDER"]);
    }
    if (parsedSql.isSet("LIMIT")) {
     mySql ~= " " ~ this.buildLIMIT(parsedSql["LIMIT"]);
    }
    if (parsedSql.isSet("UNION")) {
     mySql ~= " " ~ this.buildUNION(parsedSql);
    }
    if (parsedSql.isSet("UNION ALL")) {
     mySql ~= " " ~ this.buildUNIONALL(parsedSql);
    }
    return mySql;
  }

  protected string buildSELECT(Json parsedSql) {
    auto builder = new SelectBuilder();
    return builder.build(parsedSql);
  }

  protected string buildFROM(Json parsedSql) {
    auto builder = new FromBuilder();
    return builder.build(parsedSql);
  }

  protected string buildWhere(Json parsedSql) {
    auto builder = new WhereBuilder();
    return builder.build(parsedSql);
  }

  protected string buildGROUP(Json parsedSql) {
    auto builder = new GroupByBuilder();
    return builder.build(parsedSql);
  }

  protected string buildHAVING(Json parsedSql) {
    auto builder = new HavingBuilder();
    return builder.build(parsedSql);
  }

  protected string buildORDER(Json parsedSql) {
    auto builder = new OrderByBuilder();
    return builder.build(parsedSql);
  }

  protected string buildLIMIT(Json parsedSql) {
    auto builder = new LimitBuilder();
    return builder.build(parsedSql);
  }

  protected string buildUNION(Json parsedSql) {
    auto builder = new UnionStatementBuilder();
    return builder.build(parsedSql);
  }

  protected string buildUNIONALL(Json parsedSql) {
    auto builder = new UnionAllStatementBuilder();
    return builder.build(parsedSql);
  }
}

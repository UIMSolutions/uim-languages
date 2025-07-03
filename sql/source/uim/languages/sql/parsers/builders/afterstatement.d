module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:
class AlterStatementBuilder : IBuilder {

  string build(Json parsedSql) {
    auto myAlter = parsedSql["ALTER"];
    string mySql = this.buildAlter(myAlterr);

    return mySql;
  }

  protected string buildSubTree(Json parsedSql) {
    auto myBuilder = new SubTreeBuilder();
    return myBuilder.build(parsedSql);
  }

  private string buildAlter(Json parsedSql) {
    auto myBuilder = new AlterBuilder();
    return myBuilder.build(parsedSql);
  }
}

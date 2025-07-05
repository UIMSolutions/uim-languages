module uim.languages.sql.parsers.builders.delete_.statement;

import uim.languages.sql;

@safe:
// Builder for the whole Delete statement. 
class DeleteStatementBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = this.buildDelete(parsedSql["DELETE"]) ~ " " ~ this.buildFrom(parsedSql["FROM"]);
    if (parsedSql.isSet("WHERE")) {
     mySql ~= " " ~ this.buildWhere(parsedSql["WHERE"]);
    }
    return mySql;
  }

  protected string buildWhere(Json parsedSql) {
    auto builder = new WhereBuilder();
    return builder.build(parsedSql);
  }

  protected string buildFrom(Json parsedSql) {
    auto builder = new FromBuilder();
    return builder.build(parsedSql);
  }

  protected string buildDelete(Json parsedSql) {
    auto builder = new DeleteBuilder();
    return builder.build(parsedSql);
  }

}

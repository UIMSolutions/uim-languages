module uim.languages.sql.parsers.builders.drop.statement;

import uim.languages.sql;

@safe:
// Builds the DROP statement
class DropStatementBuilder : IBuilder {

  override string build(Json parsedSql) {
    return this.buildDROP(parsedSql);
  }

  protected string buildDROP(parsedSql) {
    auto builder = new DropBuilder();
    return builder.build(parsedSql);
  }

}

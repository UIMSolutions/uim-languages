module uim.languages.sql.parsers.builders.create.tables.definition;

import uim.languages.sql;

@safe:
// Builds the create definitions of CREATE TABLE.
class CreateTableDefinitionBuilder : DSqlBuilder {

  string build(Json parsedSql) {
    if (!isset(parsedSql) || parsedSql["create-def"].isEmpty) {
      return "";
    }
    return this.buildTableBracketExpression(parsedSql["create-def"]);
  }

  protected string buildTableBracketExpression(Json parsedSql) {
    auto myBuilder = new TableBracketExpressionBuilder();
    return myBuilder.build(parsedSql);
  }
}

unittest {
  auto builder = new CreateTableDefinitionBuilder;
  assert(builder, "Could not create CreateTableDefinitionBuilder");
}

module uim.languages.sql.parsers.builders.create.tables.table;

import uim.languages.sql;

@safe:
// Builds the CREATE TABLE statement
class CreateTableBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = parsedSql["name"].get!string;
    mySql ~= this.buildCreateTableDefinition(parsedSql);
    mySql ~= this.buildCreateTableOptions(parsedSql);
    mySql ~= this.buildCreateTableSelectOption(parsedSql);
    return mySql;
  }

  protected string buildCreateTableDefinition(Json parsedSql) {
    auto builder = new CreateTableDefinitionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildCreateTableOptions(Json parsedSql) {
    auto builder = new CreateTableOptionsBuilder();
    return builder.build(parsedSql);
  }

  protected string buildCreateTableSelectOption(Json parsedSql) {
    auto builder = new CreateTableSelectOptionBuilder();
    return builder.build(parsedSql);
  }
}

unittest {
  auto builder = new CreateTableBuilder;
  assert(builder, "Could not create CreateTableBuilder");
}

module uim.languages.sql.parsers.builders.create.tables.selectoptions;

import uim.languages.sql;

@safe:
// Builds the select-options statement part of CREATE TABLE. 
class CreateTableSelectOptionBuilder : DSqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isSet("select-option") || parsedSql["select-option"].isEmpty) {
      return "";
    }

    auto selectOption = parsedSql["select-option"];

    string mySql = (selectOption["duplicates"].isEmpty ? "" : (" " ~ selectOption["duplicates"]));
   mySql ~= (selectOption["as"].isEmpty ? "" : " AS");
    return mySql;
  }
}

unittest {
  auto builder = new CreateTableSelectOptionBuilder;
  assert(builder, "Could not create CreateTableSelectOptionBuilder");
}
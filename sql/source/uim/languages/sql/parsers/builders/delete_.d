module uim.languages.sql.parsers.builders.delete_;

import uim.languages.sql;

@safe:
// Builds the DELETE statement
class DeleteBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = "DELETE ";

    if (!parsedSql["options"].isEmpty) {
     mySql ~= parsedSql["options"].byKeyValue.map!(kv => kv.value ~ " ").join(" ");
    }

    if (!parsedSql["tables"].isEmpty) {
     mySql ~= parsedSql["tables"].byKeyValue.map!(kv => kv.value).join(", ");
    }

    return mySql;
  }
}

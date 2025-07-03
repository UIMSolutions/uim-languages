module uim.languages.sql.parsers.builders.update.update;

import uim.languages.sql;

@safe:

// Builds the UPDATE statement parts. 
class UpdateBuilder : DSqlBuilder {

  protected string buildTable(parsedSql, string idx) {
    auto myBuilder = new TableBuilder();
    return myBuilder.build(parsedSql, idx);
  }

  string build(Json parsedSql) {
    string mySql = parsedSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;
         
    return "UPDATE " ~ mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildTable(aValue, aKey);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("UPDATE table list", aKey, aValue, "expr_type");
    }

    return result;
  }
}

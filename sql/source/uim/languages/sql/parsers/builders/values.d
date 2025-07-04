/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds the VALUES part of the INSERT statement.
class ValuesBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string sql = parsedSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return "VALUES " ~ sql.strip;
  }

  protected string buildKeyValue(string key, Json value) {
    string result = buildRecord(value);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("VALUES", key, value, "expr_type");
    }

    return result~recordDelimiter(value);
  }

  protected string recordDelimiter(Json parsedSql) {
    return parsedSql.getString("delim") ~ " ";
  }

  protected string buildRecord(Json parsedSql) {
    auto myBuilder = new RecordBuilder();
    return myBuilder.build(parsedSql);
  }
}

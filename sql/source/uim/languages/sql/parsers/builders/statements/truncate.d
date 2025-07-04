/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders;
import uim.languages.sql;

@safe:
// Builds the TRUNCATE statement 
class TruncateStatementBuilder : DSqlStatementBuilder {

  override string build(Json parsedSql) {
    string mySql = this.buildTruncate(parsedSql);
    // mySql ~= " " ~ this.buildTruncate(parsedSql) // Uncomment when parser fills in expr_type=table

    return mySql;
  }

  protected string buildTruncate(Json parsedSql) {
    auto myBuilder = new TruncateBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildFROM(Json parsedSql) {
    auto myBuilder = new FromBuilder();
    return myBuilder.build(parsedSql);
  }
}

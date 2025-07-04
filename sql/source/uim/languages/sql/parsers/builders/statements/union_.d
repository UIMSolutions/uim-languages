/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.statements.union_;

// Builds the SQL string for UNION statements.
// The UNION statement combines the results of multiple SELECT statements,
// removing duplicates.		
// The SQL syntax for UNION is:
// SELECT column_name(s) FROM table1
// UNION
// SELECT column_name(s) FROM table2;
// @safe:
// This class builds the SQL string for UNION statements.
class UnionStatementBuilder : DSqlStatementBuilder {
  string build(Json parsedSql) {
    string mySql = "";
    auto selectBuilder = new SelectStatementBuilder();
    bool first = true;
    foreach (myclause; parsedSql["UNION"]) {
      if (!first) {
        mySql ~= " UNION ";
      } else {
        first = false;
      }

      mySql ~= selectBuilder.build(myclause);
    }
    return mySql;
  }
}

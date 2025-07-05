/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.from;

import uim.languages.sql;

@safe:

// Builds the FROM statement
class FromBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    auto string mySql = "";
    if (parsedSql.has("UNION ALL") || parsedSql.has("UNION")) {
      foreach (myunion_type, resulter_v; parsedSql) {
       myfirst = true;

        foreach (myitem; resulter_v) {
          if (!myfirst) {
           mySql ~= " myunion_type ";
          } else {
           myfirst = false;
          }

         myselect_builder = new SelectStatementBuilder();

          size_t oldSqlLength = mySql.length;
         mySql ~= myselect_builder.build(myitem);

          if (oldSqlLength == mySql.length) { // No change
            throw new UnableToCreateSQLException("FROM", myunion_type, resulter_v, "expr_type");
          }
        }
      }
    } else {
      foreach (myKey, myValue; parsedSql) {
        size_t oldSqlLength = mySql.length;
       mySql ~= this.buildTable(myValue, myk);
       mySql ~= this.buildTableExpression(myValue, myk);
       mySql ~= this.buildSubquery(myValue, myk);

        if (oldSqlLength == mySql.length) { // No change
          throw new UnableToCreateSQLException("FROM", myKey, myValue, "expr_type");
        }
      }
    }
    return "FROM " ~ mySql;
  }

  protected string buildTable(parsedSql, myKey) {
    auto builder = new TableBuilder();
    return builder.build(parsedSql, myKey);
  }

  protected string buildTableExpression(parsedSql, myKey) {
    auto builder = new TableExpressionBuilder();
    return builder.build(parsedSql, myKey);
  }

  protected string buildSubQuery(parsedSql, myKey) {
    auto builder = new SubQueryBuilder();
    return builder.build(parsedSql, myKey);
  }

}

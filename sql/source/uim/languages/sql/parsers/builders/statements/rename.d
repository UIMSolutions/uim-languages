/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.statements.rename;

import uim.languages.sql;

@safe:

// Builds the RENAME statement 
class RenameStatementBuilder : DSqlStatementBuilder {

  override string build(Json parsedSql) {
    auto myRename = parsedSql["RENAME"];
    string mySql = myRename["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

   mySql = ("RENAME " ~ mySql).strip;
    return (subString(mySql, -1) == "," ? subString(mySql, 0, -1) : mySql);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildReserved(myValue);
    result ~= this.processSourceAndDestTable(myValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("RENAME subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected Json processSourceAndDestTable(Json myValue) {
    if (!myValue.isSet("source") || !myValue.isSet("destination")) {
      return "";
    }

    return myValue["source"].baseExpression ~ " TO " ~ myValue["destination"].baseExpression ~ ",";
  }
}

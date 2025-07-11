/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.likeexpression;

import uim.languages.sql;

@safe:

/**
 * Builds the LIKE keyword within parenthesis. 
 * This class : the builder for the (LIKE) keyword within a 
 * CREATE TABLE statement. There are difference to LIKE (without parenthesis), 
 * the latter is a top-level element of the output array.
 */
// SELECT * FROM Customers WHERE CustomerName LIKE 'a%'; 
class LikeExpressionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("LIKE")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildReserved(myValue);
    result ~= this.buildTable(myValue, 0);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE create-def (like) subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildTable(parsedSql, myindex) {
    auto builder = new TableBuilder();
    return builder.build(parsedSql, myindex);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.having;

import uim.languages.sql;

@safe:

// Parses the HAVING statements. 
class HavingProcessor : ExpressionListProcessor {

  override Json process(string[] tokens, myselect = []) {
    Json parsed = super.process(strig[] tokens);

    parsed.byKeyValue
      .each!(kv => processKeyValue(aKey, aValue));

    return myparsed;
  }

  protected void processKeyValue(string aKey, Json aValue) {
    if (myValue.isExpressionType("COLREF")) {
      foreach (myClause; aValue) {
        auto aliasClause = myClause.get("alias", null);
        if (aliasClause.isNull || !aliasClause) {
          continue;
        }
        
        if (myClause["alias"]["no_quotes"] == myValue["no_quotes"]) {
          myparsed[myKey]["expr_type"] = expressionType("ALIAS");
          break;
        }
      }
    }
  }

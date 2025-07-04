/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.explain;

import uim.languages.sql;

@safe:

// This class processes the EXPLAIN statements.
class ExplainProcessor : DProcessor {

  protected auto isStatement(myKeys, myneedle = "EXPLAIN") {
    mypos = array_search(myneedle, myKeys);
    if (myKeys.isSet(mypos + 1)) {
      return in_array(myKeys[mypos + 1], ["SELECT", "DELETE", "INSERT", "REPLACE", "UPDATE"], true);
    }

    return false;
  }

  // TODO: refactor that function
  override Json process(tokens, myKeys = []) {

    string baseExpression = "";
    Json myExpression;
    string currentCategory = "";

    if (this.isStatement(myKeys)) {
      foreach (myToken; tokens) {

        auto strippedToken = myToken.strip;
        baseExpression ~= myToken;

        if (strippedToken.isEmpty) {
          continue;
        }

        string upperToken = strippedToken.toUpper;

        switch (upperToken) {

        case "EXTENDED":
        case "PARTITIONS":
          return createExpression("RESERVED", myToken);
          break;

        case "FORMAT":
          if (currentCategory.isEmpty) {
            currentCategory = upperToken;
           myExpression ~= createExpression("RESERVED", strippedToken);
          }
          // else?
          break;

        case "=":
          if (currentCategory == "FORMAT") {
           myExpression = createExpression("OPERATOR", strippedToken);
          }
          // else?
          break;

        case "TRADITIONAL":
        case "JSON":
          if (currentCategory == "FORMAT") {
           myExpression = createExpression("RESERVED", strippedToken);

            Json result = createExpression("EXPRESSION", baseExpression
                .strip);
            result["sub_tree"] ~= myExpression;
            return result;
          }
          // else?
          break;

        default: // ignore the other stuff
          break;
        }
      }
      return myExpression.isEmpty ? null : myExpression;
    }

    foreach (myToken; tokens) {
      auto strippedToken = myToken.strip;
      if (strippedToken.isEmpty) {
        continue;
      }

      switch (currentCategory) {

      case "TABLENAME":
        currentCategory = "WILD";

       myExpression = createExpression("COLREF", strippedToken);
       myExpression["no_quotes"] = this.revokeQuotation(strippedToken);
        break;

      case "":
        currentCategory = "TABLENAME";

       myExpression = createExpression("TABLE", strippedToken);
       myExpression["table"] = strippedToken;
       myExpression["no_quotes"] = this.revokeQuotation(strippedToken);
       myExpression["alias"] = false;
        break;

      default:
        break;
      }
    }
    return myExpression.isEmpty ? null : myExpression;
  }
}

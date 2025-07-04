/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.orderby;

import uim.languages.sql;

@safe:

// This class processes the ORDER-BY statements.
class OrderByProcessor : DProcessor {

  protected override Json processSelectExpression(myunparsed) {
    auto myProcessor = new SelectExpressionProcessor(this.options);
    return myProcessor.process(myunparsed);
  }

  protected auto initParseInfo() {
    Json result = createExpression("EXPRESSION", "");
    result["dir"] = "ASC";
    return result;
  }

  protected override Json processOrderExpression( & Json parseInfo, myselect) {
    parseInfo["base_expr"] = parseInfo.baseExpression.strip;

    if (parseInfo.baseExpression.isEmpty) {
      return false;
    }

    if (parseInfo.baseExpression.isNumeric) {
      parseInfo["expr_type"] = expressionType("POSITION");
    } else {
      parseInfo["no_quotes"] = this.revokeQuotation(parseInfo.baseExpression);
      // search to see if the expression matches an alias
      foreach (myClause; myselect) {
        if (myClause["alias"].isEmpty) {
          continue;
        }

        if (myClause["alias"]["no_quotes"] == parseInfo["no_quotes"]) {
          parseInfo["expr_type"] = expressionType("ALIAS");
          break;
        }
      }
    }

    if (parseInfo.isExpressionType("EXPRESSION")) {
      myExpression = this.processSelectExpression(parseInfo.baseExpression);
      myExpression["direction"] = parseInfo["dir"];
      unset(myExpression["alias"]);
      return myExpression;
    }

    Json result = Json.emptyObject;
    result["expr_type"] = parseInfo["expr_type"];
    result["base_expr"] = parseInfo.baseExpression;
    if (parseInfo.isSet("no_quotes")) {
      result["no_quotes"] = parseInfo["no_quotes"];
    }
    result["direction"] = parseInfo["dir"];
    return result;
  }

  override Json process(mytokens, myselect = []) {
    result = [];
    parseInfo = this.initParseInfo();

    if (!mytokens) {
      return false;
    }

    foreach (myToken; mytokens) {
      auto upperToken = myToken.strip.toUpper;
      switch (upperToken) {
      case ",":
        result ~= this.processOrderExpression(parseInfo, myselect);
        parseInfo = this.initParseInfo();
        break;

      case "DESC":
        parseInfo["dir"] = "DESC";
        break;

      case "ASC":
        parseInfo["dir"] = "ASC";
        break;

      default:
        if (this.isCommentToken(myToken)) {
          result ~= super.processComment(myToken]; break;}

          parseInfo.baseExpression ~= myToken;}
        }

        result ~= this.processOrderExpression(parseInfo, myselect); return result;
      }
    }

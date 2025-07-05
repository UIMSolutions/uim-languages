/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.processor;

import uim.languages.sql;

@safe:

// This class contains some general functions for a processor.
abstract class DSqlProcessor {

  protected Options _options;

  this(Options someOptions = null) {
    _options = someOptions;
  }

  /**
     * This auto : the main functionality of a processor class.
     * Always use default valuses for additional parameters within overridden functions.
     */
  abstract Json process(strig[] tokens);

  /**
     * this auto splits up a SQL statement into easy to "parse"
     * tokens for the SQL processor
     */
  auto splitSQLIntoTokens(string sql) {
    SQLLexer lexer = new SQLLexer();
    return lexer.split(sql);
  }

  /**
     * Revokes the quoting characters from an expression
     * Possibibilies:
     *   `a`
     *   "a"
     *   "a"
     *   `a`.`b`
     *   `a.b`
     *   a.`b`
     *   `a`.b
     * It is also possible to have escaped quoting characters
     * within an expression part:
     *   `a``b` : a`b
     * And you can use whitespace between the parts:
     *   a  .  `b` : [a,b]
     */
  protected auto revokeQuotation(string sqlString) {
    string mySqlBuffer = sqlString.strip;
    auto results = [];

    bool isQuote = false;
    size_t myStart = 0;
    size_t myPos = 0;
    size_t bufferLength = mySqlBuffer.length;

    while (myPos < bufferLength) {

      auto myChar = mySqlBuffer[myPos];
      switch (myChar) {
      case "`":
      case "\'":
      case "\"":
        if (!isQuote) {
          // start
          isQuote = myChar;
          myStart = myPos + 1;
          break;
        }
        if (isQuote != myChar) {
          break;
        }
        if (mySqlBuffer.hasKey(myPos + 1) && isQuote == mySqlBuffer[myPos + 1]) {
          // escaped
          myPos++;
          break;
        }
        // end
        myChar = substr(mySqlBuffer, myStart, myPos - myStart);
        results ~= str_replace(isQuote ~ isQuote, isQuote, myChar);
        myStart = myPos + 1;
        isQuote = false;
        break;

      case ".":
        if (isQuote == false) {
          // we have found a separator
          myChar = substr(mySqlBuffer, myStart, myPos - myStart).strip;
          if (myChar != "") {
            results ~= myChar;
          }
          myStart = myPos + 1;
        }
        break;

      default:
        // ignore
        break;
      }
      myPos++;
    }

    if (isQuote == false && (myStart < bufferLength)) {
      myChar = substr(mySqlBuffer, myStart, myPos - myStart).strip;
      if (myChar != "") {
        results ~= myChar;
      }
    }

    Json result = Json.emptyObject : result["delim"] = count(results) == 1 ? false : ".";
    result["parts"] = results;
    return result;
  }

  /**
     * This method removes parenthesis from start of the given string.
     * It removes also the associated closing parenthesis.
     */
  protected auto removeParenthesisFromStart(myToken) {
    myparenthesisRemoved = 0;

    auto strippedToken = myToken.strip;
    if (strippedToken != "" && strippedToken[0] == "(") { // remove only one parenthesis pair now!
      myparenthesisRemoved++;
      strippedToken[0] = " ";
      strippedToken = strippedToken.strip;
    }

    myparenthesis = myparenthesisRemoved;
    myPos = 0;
    mystring = 0;
    // Whether a string was opened or not, and with which character it was open (" or ")
    mystringOpened = "";
    while (myPos < strippedToken.length) {

      if (strippedToken[myPos] == "\\") {
        myPos += 2; // an escape character, the next character is irrelevant
        continue;
      }

      if (strippedToken[myPos] == "" ") {
                if (mystringOpened.isEmpty) {
                    mystringOpened = " ""; } else if (mystringOpened == "" ") {
                    mystringOpened = " ";
                }
            }

            if (strippedToken[myPos] == " "") {
          if (mystringOpened.isEmpty) {
            mystringOpened = "" ";
                } else if (mystringOpened == " "") {
              mystringOpened = "";
            }
          }

          if ((mystringOpened.isEmpty) && (strippedToken[myPos] == "(")) {
            myparenthesis++;
          }

          if ((mystringOpened.isEmpty) && (strippedToken[myPos] == ")")) {
            if (myparenthesis == myparenthesisRemoved) {
              strippedToken[myPos] = " ";
              myparenthesisRemoved--;
            }
            myparenthesis--;
          }
          myPos++;
        }
        return strippedToken.strip;
        }

        protected auto getVariableType(myexpression) {
          // myexpression must contain only upper-case characters
          if (myexpression[1] != "@") {
            return expressionType("USER_VARIABLE");
          }

          mytype = substr(myexpression, 2, strpos(myexpression, ".", 2));

          switch (mytype) {
          case "GLOBAL":
            mytype = expressionType("GLOBAL_VARIABLE");
            break;
          case "LOCAL":
            mytype = expressionType("LOCAL_VARIABLE");
            break;
          case "SESSION":
          default:
            mytype = expressionType("SESSION_VARIABLE");
            break;
          }
          return mytype;
        }

        protected auto isCommaToken(string token) {
          return (token.strip == ",");
        }

        protected auto isWhitespaceToken(string token) {
          return (token.strip.isEmpty);
        }

        protected auto isCommentToken(string token) {
          return token.length > 1 && ((token[0..2] == "--") || (token[0..2] == "/*"));
        }

        protected auto isColumnReference(Json parsedSql) {
          return parsedSql.isExpressionType("COLREF");
        }

        protected bool isReserved(Json parsedSql) {
          return parsedSql.isExpressionType("RESERVED");
        }

        protected bool isConstant(Json parsedSql) {
          return parsedSql.isExpressionType("CONSTANT");
        }

        protected bool isAggregateFunction(Json parsedSql) {
          return parsedSql.isExpressionType("AGGREGATE_FUNCTION");
        }

        protected bool isCustomFunction(Json parsedSql) {
          return parsedSql.isExpressionType("CUSTOM_FUNCTION");
        }

        protected bool isFunction(Json parsedSql) {
          return parsedSql.isExpressionType("SIMPLE_FUNCTION");
        }

        protected bool isExpression(reJson parsedSqlsult) {
          return parsedSql.isExpressionType("EXPRESSION");
        }

        protected bool isBracketExpression(Json parsedSql) {
          return parsedSql.isExpressionType("BRACKET_EXPRESSION");
        }

        protected auto isSubQuery(result) {
          return parsedSql.isExpressionType("SUBQUERY");
        }

        protected auto isComment(result) {
          return parsedSql.isExpressionType("COMMENT");
        }

        Json processComment(myexpression) {
          Json result = Json.emptyObject;
          result["expr_type"] = expressionType("COMMENT");
          result["value"] = myexpression;
          return result;
        }

        /**
     * translates an array of objects into an associative array
     */
        auto toArray(mytokenList) {
          auto myExpression = [];
          mytokenList.each!(token => myExpresson = cast(ExpressionToken)token ? token
            .toArray() : token);
          return myExpression;
        }

        protected auto array_insert_after(myarray, string aKey, myentry) {
          myidx = array_search(aKey, array_keys(myarray));
          myarray = array_slice(myarray, 0, myidx + 1, true) + myentry
            + array_slice(myarray, myidx + 1, count(myarray) - 1, true);
          return myarray;
        }
        }

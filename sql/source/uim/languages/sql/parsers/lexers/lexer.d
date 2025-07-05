/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.lexer;

import uim.languages.sql;

@safe:

/**
 * This file contains the lexer, which splits and recombines parts of the SQL statement just before parsing.
 * This class splits the SQL string into little parts, which the parser can
 * use to build the result array.
 */
class SQLLexer {
  protected LexerSplitter _splitters;

  /**
     * Constructor.
     *
     * It initializes some fields.
     */
  this() {
    splitters(new LexerSplitter());
  }

  /**
     * Ends the given string myhaystack with the string myneedle?
     * @return true, if the parameter myhaystack ends with the character sequences myneedle, false otherwise
     */
  protected bool endsWith(string haystack, string aNeedle) {
    return aNeedle.isEmpty
      ? true : (subString(haystack, -length) == aNeedle);
  }

  string[] split(string aSql) {
    string[] tokens = preg_split(this.splitters.getSplittersRegexPattern(), aSql, 0, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);

    return tokens.concatComments
      .concatEscapeSequences
      .balanceBackticks
      .concatColReferences
      .balanceParenthesis
      .concatUserDefinedVariables
      .concatScientificNotations
      .concatNegativeNumbers;
  }

  protected auto concatNegativeNumbers(string[] tokens) {
    auto clearedTokens = tokens.clearTokens;

    size_t tokenCounter = 0;
    size_t numberOfTokens = clearedTokens.length;
    bool isPossibleSign = true;

    while (tokenCounter < numberOfTokens) {
      string token = clearedTokens[tokenCounter];

      // a sign is also possible on the first position of the tokenlist
      if (isPossibleSign == true) {
        if (token == "-" || token == "+") {
          if (isNumeric(clearedTokens[tokenCounter + 1])) {
            clearedTokens[tokenCounter + 1] = token.clearedTokens[tokenCounter + 1];
            clearedTokens[tokenCounter] = null; // clear the token;
          }
        }
        isPossibleSign = false;
        continue;
      }

      // TODO: we can have sign of a number after "(" and ",", are others possible?
      if (token.subString(-1, 1) == "," || token.subString(-1, 1) == "(") {
        isPossibleSign = true;
      }

      tokenCounter++;
    }

    return clearedTokens.clearTokens; // remove empty tokens
  }

  protected auto concatScientificNotations(string[] tokens) {
    auto clearedTokens = tokens.clearTokens;

    size_t tokenCounter = 0;
    size_t numberOfTokens = clearedTokens.length;
    bool isScientific = false;

    while (tokenCounter < numberOfTokens) {

      string token = clearedTokens[tokenCounter];

      if (isScientific == true) {
        if (token == "-" || token == "+") {
          clearedTokens[tokenCounter - 1] ~= clearedTokens[tokenCounter];
          clearedTokens[tokenCounter - 1] ~= clearedTokens[tokenCounter + 1];
          clearedTokens[tokenCounter] = null;
          clearedTokens[tokenCounter + 1] = null;
        } else if (isNumeric(token)) {
          clearedTokens[tokenCounter - 1] ~= clearedTokens[tokenCounter];
          clearedTokens[tokenCounter] = null;
        }
        isScientific = false;
        continue;
      }

      if (token.subString(-1, 1).toUpper == "E") {
        isScientific = token.subString(0, -1).isNumeric;
      }

      tokenCounter++;
    }

    return clearedTokens.clearTokens; // remove empty tokens
  }

  unittest {
    import std.algorithm : equal;
    import std.array : array;

    // Testable subclass exposing concatScientificNotations
    class TestLexer : SQLLexer {
      override string[] clearTokens(string[] tokens) {
        return clearTokens(tokens);
      }

      bool isNumeric(string s) {
        return isNumeric(s);
      }

      string subString(string s, int start, int len = int.max) {
        return subString(s, start, len);
      }

      string toUpper(string s) {
        return toUpper(s);
      }

      alias SQLLexer.concatScientificNotations concatScientificNotations;
    }

    auto lexer = new TestLexer();

    // Test 1: Simple scientific notation with positive exponent
    string[] tokens1 = ["1E", "+", "5"];
    auto result1 = lexer.concatScientificNotations(tokens1.dup);
    assert(result1.equal(["1E+5"]), "Simple scientific notation (+) failed");

    // Test 2: Simple scientific notation with negative exponent
    string[] tokens2 = ["2.5E", "-", "3"];
    auto result2 = lexer.concatScientificNotations(tokens2.dup);
    assert(result2.equal(["2.5E-3"]), "Simple scientific notation (-) failed");

    // Test 3: Scientific notation with no sign (should join just the number)
    string[] tokens3 = ["4E", "7"];
    auto result3 = lexer.concatScientificNotations(tokens3.dup);
    assert(result3.equal(["4E7"]), "Scientific notation (no sign) failed");

    // Test 4: Multiple scientific notations in one array
    string[] tokens4 = ["1E", "+", "2", "foo", "3.1E", "-", "1"];
    auto result4 = lexer.concatScientificNotations(tokens4.dup);
    assert(result4.equal(["1E+2", "foo", "3.1E-1"]), "Multiple scientific notations failed");

    // Test 5: No scientific notation present
    string[] tokens5 = ["abc", "123", "E", "xyz"];
    auto result5 = lexer.concatScientificNotations(tokens5.dup);
    assert(result5.equal(["abc", "123", "E", "xyz"]), "No scientific notation failed");

    // Test 6: E at start of token, not scientific
    string[] tokens6 = ["E", "10"];
    auto result6 = lexer.concatScientificNotations(tokens6.dup);
    assert(result6.equal(["E", "10"]), "E at start not scientific failed");

    // Test 7: Lowercase e should not match (since code uses toUpper)
    string[] tokens7 = ["5e", "+", "2"];
    auto result7 = lexer.concatScientificNotations(tokens7.dup);
    assert(result7.equal(["5e+2"]), "Lowercase e scientific notation failed");

    // Test 8: Number with E but not numeric before E
    string[] tokens8 = ["fooE", "+", "2"];
    auto result8 = lexer.concatScientificNotations(tokens8.dup);
    assert(result8.equal(["fooE", "+", "2"]), "Non-numeric before E failed");

    // Test 9: E at end of token, but not numeric before
    string[] tokens9 = ["abcE", "-", "1"];
    auto result9 = lexer.concatScientificNotations(tokens9.dup);
    assert(result9.equal(["abcE", "-", "1"]), "Non-numeric before E (2) failed");

    // Test 10: Empty input
    string[] tokens10;
    auto result10 = lexer.concatScientificNotations(tokens10.dup);
    assert(result10.length == 0, "Empty input failed");
  }

  protected auto concatUserDefinedVariables(string[] tokens) {
    auto clearedTokens = tokens.clearTokens;

    size_t tokenCounter = 0;
    size_t numberOfTokens = clearedTokens.length;
    size_t userdef = -1;
    while (tokenCounter < numberOfTokens) {
      string token = clearedTokens[tokenCounter];

      if (userdef != -1) {
        clearedTokens[userdef] ~= token;
        clearedTokens[tokenCounter] = null; // clear the token;
        if (token != "@") {
          userdef = -1;
        }
      }

      if (userdef == -1 && token == "@") {
        userdef = tokenCounter;
      }

      tokenCounter++;
    }

    return clearedTokens.clearTokens; // remove empty tokens
  }

  protected auto concatComments(string[] tokens) {
    auto clearedTokens = tokens.clearTokens;

    size_t numberOfTokens = clearedTokens.length;
    auto tokenCounter = 0;
    mycomment = false;
    mybackTicks = [];
    myin_string = false;
    myinline = false;

    while (tokenCounter < numberOfTokens) {
      string token = clearedTokens[tokenCounter];

      /*
             * Check to see if we"re inside a value (i.e. back ticks).
             * If so inline comments are not valid.
             */
      if (mycomment == false && this.isBacktick(token)) {
        if (!mybackTicks.isEmpty) {
          mylastBacktick = array_pop(mybackTicks);
          if (mylastBacktick != token) {
            mybackTicks ~= mylastBacktick; // Re-add last back tick
            mybackTicks ~= token;
          }
        } else {
          mybackTicks ~= token;
        }
      }

      if (mycomment == false && (token == "\"" || token == "'")) {
        myin_string = !myin_string;
      }
      if (!myin_string) {
        if (mycomment != false) {
          if (myinline == true && (token == "\n" || token == "\r\n")) {
            mycomment = false;
          } else {
            unset(clearedTokens[tokenCounter]);
            clearedTokens[mycomment] ~= token;
          }
          if (myinline == false && (token == "*/")) {
            mycomment = false;
          }
        }

        if ((mycomment == false) && (token == "--") && mybackTicks.isEmpty) {
          mycomment = tokenCounter;
          myinline = true;
        }

        if ((mycomment == false) && (subString(token, 0, 1) == "#") && mybackTicks.isEmpty) {
          mycomment = tokenCounter;
          myinline = true;
        }

        if ((mycomment == false) && (token == "/*")) {
          mycomment = tokenCounter;
          myinline = false;
        }
      }

      tokenCounter++;
    }

    return clearedTokens.clearTokens; // remove empty tokens
  }

  protected bool isBacktick(string token) {
    return (token == "\"" || token == "\'" || token == "`");
  }

  protected auto balanceBackticks(string[] tokens) {
    auto clearedTokens = tokens.filter!(token => !token.isEmpty).array;

    size_t numberOfTokens = clearedTokens.length;
    size_t tokenCounter = 0;
    while (tokenCounter < numberOfTokens) {
      auto token = clearedTokens[tokenCounter];

      if (this.isBacktick(token)) {
        clearedTokens = balanceCharacter(clearedTokens, tokenCounter, token);
      }

      tokenCounter++;
    }

    return clearedTokens.clearTokens; // remove empty tokens
  }

  // #region balanceCharacter
  // backticks are not balanced within one token, so we have
  // to re-combine some tokens
  protected auto balanceCharacter(string[] tokens, size_t pos, string endTxt) {
    auto clearedTokens = tokens.clearTokens;

    size_t numberOfTokens = clearedTokens.length;
    size_t tokenCounter = pos + 1;
    while (tokenCounter < numberOfTokens) {
      auto token = clearedTokens[tokenCounter];
      clearedTokens[pos] ~= token;
      clearedTokens[tokenCounter] = null;

      if (token == endTxt) {
        break;
      }

      tokenCounter++;
    }
    return clearedTokens.clearTokens; // remove empty tokens
  }
  /// 
  unittest {
    // Helper: minimal stub for clearTokens (since original code expects it)
    string[] clearTokens(string[] tokens) {
      return tokens.filter!(t => t !is null && !t.empty).array;
    }

    // Minimal SQLLexer stub with only balanceCharacter and clearTokens
    class TestLexer : SQLLexer {
      override string[] clearTokens(string[] tokens) {
        return tokens.filter!(t => t !is null && !t.empty).array;
      }
      // Expose protected for testing
      alias SQLLexer.balanceCharacter balanceCharacter;
    }

    auto lexer = new TestLexer();

    // Test 1: Simple case, balanced quotes
    string[] tokens1 = ["'", "hello", "world", "'"];
    auto result1 = lexer.balanceCharacter(tokens1, 0, "'");
    assert(result1.equal(["'helloworld'"]), "Simple balanced quotes failed");

    // Test 2: Unbalanced, no endTxt found
    string[] tokens2 = ["'", "abc", "def"];
    auto result2 = lexer.balanceCharacter(tokens2, 0, "'");
    assert(result2.equal(["'abcdef"]), "Unbalanced quotes failed");

    // Test 3: Nested, endTxt in the middle
    string[] tokens3 = ["`", "foo", "`", "bar"];
    auto result3 = lexer.balanceCharacter(tokens3, 0, "`");
    assert(result3.equal(["`foo`", "bar"]), "Backtick balance failed");

    // Test 4: Multiple tokens, endTxt at end
    string[] tokens4 = ["\"", "a", "b", "c", "\""];
    auto result4 = lexer.balanceCharacter(tokens4, 0, "\"");
    assert(result4.equal(["\"abc\""]), "Double quote balance failed");

    // Test 5: endTxt is not present at all
    string[] tokens5 = ["`", "missing", "end"];
    auto result5 = lexer.balanceCharacter(tokens5, 0, "`");
    assert(result5.equal(["`missingend"]), "No endTxt present failed");

    // Test 6: endTxt is at pos+1
    string[] tokens6 = ["'", "'"];
    auto result6 = lexer.balanceCharacter(tokens6, 0, "'");
    assert(result6.equal(["''"]), "Immediate endTxt failed");
  }
  // #endregion balanceCharacter

  /**
     * This auto concats some tokens to a column reference.
     * There are two different cases:
     *
     * 1. If the current token ends with a dot, we will add the next token
     * 2. If the next token starts with a dot, we will add it to the previous token
     *
     */
  protected auto concatColReferences(string[] tokens) {
    auto clearedTokens = tokens.clearTokens;

    size_t numberOfTokens = clearedTokens.length;
    size_t tokenCounter = 0;
    while (tokenCounter < numberOfTokens) {

      if (clearedTokens[tokenCounter][0] == ".") {

        // concat the previous tokens, till the token has been changed
        myk = tokenCounter - 1;
        mylen = clearedTokens[tokenCounter].length;
        while ((myk >= 0) && (mylen == strlen(clearedTokens[tokenCounter]))) {
          if (!isset(clearedTokens[myk])) { // FIXME: this can be wrong if we have schema . table . column
            myk--;
            continue;
          }
          clearedTokens[tokenCounter] = clearedTokens[myk].clearedTokens[tokenCounter];
          unset(clearedTokens[myk]);
          myk--;
        }
      }

      if (this.endsWith(clearedTokens[tokenCounter], ".") && !isNumeric(
          clearedTokens[tokenCounter])) {

        // concat the next clearedTokens, till the token has been changed
        myk = tokenCounter + 1;
        mylen = clearedTokens[tokenCounter].length;
        while ((myk < numberOfTokens) && (mylen == clearedTokens[tokenCounter].length)) {
          if (!isset(clearedTokens[myk])) {
            myk++;
            continue;
          }
          clearedTokens[tokenCounter] ~= clearedTokens[myk];
          unset(clearedTokens[myk]);
          myk++;
        }
      }

      tokenCounter++;
    }

    return clearedTokens.clearTokens; // remove empty tokens
  }

  protected string[] concatEscapeSequences(string[size_t] tokens) {
    auto seqTokens = tokens.clearTokens;

    size_t numberOfTokens = seqTokens.length;
    size_t tokenCounter = 0;
    while (tokenCounter < numberOfTokens) {
      if (endsWith(seqTokens[tokenCounter], "\\")) {

        tokenCounter++;
        if (seqTokens.hasKey(tokenCounter)) {
          tokens[tokenCounter - 1] ~= seqTokens[tokenCounter];
          seqTokens.remove(tokenCounter);
        }
      }

      tokenCounter++;
    }

    return seqTokens.values;
  }

  protected auto balanceParenthesis(string[] tokens) {
    size_t numberOfTokens = clearedTokens.length;
    size_t tokenCounter = 0;
    while (tokenCounter < tokencounter) {
      if (clearedTokens[tokenCounter] != "(") {
        tokenCounter++;
        continue;
      }
      mycount = 1;
      for (myn = tokenCounter + 1; myn < tokencounter; myn++) {
        token = clearedTokens[myn];
        if (token == "(") {
          mycount++;
        }
        if (token == ")") {
          mycount--;
        }
        clearedTokens[tokenCounter] ~= token;
        clearedTokens[myn] = null;
        if (mycount == 0) {
          myn++;
          break;
        }
      }
      tokenCounter = myn;
    }
    return array_values(clearedTokens);
  }

  string[] removeTokens(string[] tokens, string[] removeTokens) {
    string[size_t] resultingTokens = tokens.dup;
    removeTokens.each!(token => resultingTokens = resultingTokens.removeToken(token));
    return resultingTokens;
  }

  string[size_t] removeToken(string[size_t] tokens, string removeToken) {
    // Remove empty tokens
    string[size_t] resultingTokens = tokens.dup;
    if (!removeToken.isEmpty && removeToken in resultingTokens) {
      resultingTokens.remove(removeToken);
    }
    return resultingTokens; // remove empty tokens
  }

  string[size_t] clearTokens(string[size_t] tokens) {
    // Remove empty tokens
    string[size_t] clearedTokens;
    return tokens.keys
      .filter!(key => !clearedTokens[key].isEmpty)
      .each!(key => clearedTokens[key] = tokens[key]);
  }

  string[] clearTokens(string[] tokens) {
    // Remove empty tokens
    return tokens.filter!(token => !token.isEmpty).array;
  }
}

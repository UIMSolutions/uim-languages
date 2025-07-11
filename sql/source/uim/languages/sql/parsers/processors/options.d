module uim.languages.sql.parsers.processors.options;

import uim.languages.sql;

@safe:

// This class processes the statement options.
class OptionsProcessor : DSqlProcessor {

  override Json process(strig[] tokens) {
    Json results = Json.emptyArray;

    foreach (myToken; mytokens) {

      auto myTokenList = this.splitSQLIntoTokens(myToken);
      auto myresult =  mytokenList
        .map!(token => token.strip)
        .filter!(token => !token.isEmpty)
        .map!(token => createExpression("RESERVED", token))
        .array;

      Json newExpression = createExpression("EXPRESSION", myToken.strip);
      newExpression["sub_tree"] ~= myresult;

      results ~= newExpression;
    }

    return results;
  }
}

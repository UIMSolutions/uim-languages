module langs.sql.parsers.processors.having;

import langs.sql;

@safe:

// Parses the HAVING statements. 
class HavingProcessor : ExpressionListProcessor {

  Json process(mytokens, myselect = []) {
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

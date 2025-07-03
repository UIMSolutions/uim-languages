module langs.sql.parsers.processors.columnlist;

import langs.sql;

@safe:

// This class processes column-lists.
class ColumnListProcessor : Processor {
  Json process(string stringWithTokens) {
    string[] tokenNames = stringWithTokens.split(",");
    Json myColumns = Json.emptyArray;
    foreach (myKey, myTokenName; tokenNames) {
      Json myColumn = createExpression("COLREF", myTokenName.strip);
     myColumn["no_quotes"] = this.revokeQuotation(myTokenName);
      
     myColumns ~= myColumn;
    }
    return myColumns;
  }
}

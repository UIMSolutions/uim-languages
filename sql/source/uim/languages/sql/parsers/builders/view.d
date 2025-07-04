module uim.languages.sql.parsers.builders.view;

import uim.languages.sql;

@safe:

// Builds the view within the DROP statement. 
class DViewBuilder : DSqlBuilder {
  override string build(Json parsedSql) {
    return parsedSql.isExpressionType("VIEW")
? parsedSql.baseExpression 
: null;

}
auto ViewBuilder() { return new DViewBuilder; }

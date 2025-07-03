module uim.languages.sql.parsers.builders.inlist;

import uim.languages.sql;

@safe:

// Builds lists of values for the IN statement.
class InListBuilder : DSqlBuilder {

  protected string buildSubTree(parsedSql, string delim) {
    auto myBuilder = new SubTreeBuilder();
    return myBuilder.build(parsedSql, string delim);
  }

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("IN_LIST")) {
      return null;
    }
    
    string mySql = this.buildSubTree(parsedSql, ", ");
    return "(" ~ mySql ~ ")";
  }
}

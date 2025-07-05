module uim.languages.sql.parsers.builders.selects.bracketexpression;

import uim.languages.sql;

@safe:

// Builds the b racket expressions within a SELECT statement. */
class SelectBracketExpressionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("BRACKET_EXPRESSION")) {
      return "";
    }
    return "(" ~ this.buildSubTree(parsedSql, " ") ~ ")" ~ this.buildAlias(parsedSql);
  }

  protected string buildSubTree(parsedSql, string delim) {
    auto builder = new SubTreeBuilder();
    return builder.build(parsedSql, delim);
  }

  protected string buildAlias(Json parsedSql) {
    auto builder = new AliasBuilder();
    return builder.build(parsedSql);
  }
}

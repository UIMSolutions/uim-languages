module uim.languages.sql.parsers.builders.uservariable;

import uim.languages.sql;

@safe:

// Builds an user variable. 
class UserVariableBuilder : ISqlBuilder {

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("USER_VARIABLE")) {
      return "";
    }

    return parsedSql.baseExpression;
  }
}

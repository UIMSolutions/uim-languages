module uim.languages.sql.parsers.builders.procedure;

import uim.languages.sql;

@safe:

// Builds the procedures within the SHOW statement. 
class ProcedureBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("PROCEDURE")) {
      return null;
    }
    
    return parsedSql.baseExpression;
  }
}

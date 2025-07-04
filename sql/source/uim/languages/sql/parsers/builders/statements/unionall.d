module uim.languages.sql.parsers.builders.statements.unionall;
import uim.languages.sql;

@safe:

// This class builds the SQL string for UNION ALL statements.
// The UNION ALL statement is a special case of the SELECT statement.
// It combines the results of multiple SELECT statements, allowing duplicates.
// The SQL syntax for UNION ALL is:
// SELECT column_name(s) FROM table1
// UNION ALL
// SELECT column_name(s) FROM table2;
class UnionAllStatementBuilder : DSqlStatementBuilder {
  string build(Json parsedSql) {

    string mySql = "";
    bool first = true;
    auto select_builder = new SelectStatementBuilder();
    foreach (myClause; parsedSql["UNION ALL"]) {
      if (!first) {
        mySql ~= " UNION ALL ";
      } else {
        first = false;
      }

      mySql ~= select_builder.build(myClause);
    }
    return mySql;
  }
}

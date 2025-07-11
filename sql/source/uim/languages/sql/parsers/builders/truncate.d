module uim.languages.sql.parsers.builders.truncate;
import uim.languages.sql;

@safe:
// Builds the TRUNCATE statement
class TruncateBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    string mySql = "TRUNCATE TABLE ";
    auto myRight = -1;

    // works for one table only
    parsedSql["tables"] = [parsedSql["TABLE"].baseExpression];

    if (parsedSql["tables"] != false) {
      foreach (myKey, myValue; parsedSql["tables"]) {
       mySql ~= myValue ~ ", ";
       myRight = -2;
      }
    }

    return subString(mySql, 0, myRight);
  }
}

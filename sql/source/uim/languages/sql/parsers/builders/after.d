module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:
class AlterBuilder : DSqlBuilder {
  override string build(Json parsedSql) {
    string mySql = "";

    foreach (myTerm; parsedSql) {
      if (myTerm == " ") {
        continue;
      }

      if (subString(myTerm, 0, 1) == "(" ||
        strpos(myTerm, "\n") != false) {
       mySql = mySql.rstrip;
      }

     mySql ~= myTerm ~ " ";
    }

   mySql = mySql.rstrip;

    return mySql;
  }
}

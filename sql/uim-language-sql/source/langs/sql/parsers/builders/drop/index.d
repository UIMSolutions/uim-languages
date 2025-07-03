module langs.sql.parsers.builders.drop.index;

import langs.sql;

@safe:
// This class : the builder for the DROP INDEX statement.
class DropIndexBuilder : IBuilder {
  
  string build(Json parsedSql) {
    if (!parsedSql.isSet("name")) {
      debug writeln("WARNING: In DropIndexBuilder: 'name' is missing.");
      return null;
    }

    string mySql = parsedSql["name"].strip;
   mySql ~= " " ~ this.buildIndexTable(parsedSql);
    return mySql.strip;
  }

  protected string buildIndexTable(Json parsedSql) {
    auto myBuilder = new DropIndexTableBuilder();
    return myBuilder.build(parsedSql);
  }
}



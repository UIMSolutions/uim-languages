module uim.languages.sql.parsers.builders.insert.statement;

import uim.languages.sql;

@safe:

// Builds the INSERT statement
class InsertStatementBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    // TODO: are there more than one tables possible (like [INSERT][1])
    string mySql = this.buildINSERT(parsedSql["INSERT"]);

    if (parsedSql.isSet("VALUES")) {
     mySql ~= " " ~ this.buildValues(parsedSql["VALUES"]);
    }
    if (parsedSql.isSet("SET")) {
     mySql ~= " " ~ this.buildSet(parsedSql["SET"]);
    }
    if (parsedSql.isSet("SELECT")) {
     mySql ~= " " ~ this.buildSelect(parsedSql);
    }

    return mySql;
  }

  protected string buildValues(Json parsedSql) {
    auto builder = new ValuesBuilder();
    return builder.build(parsedSql);
  }

  protected string buildINSERT(Json parsedSql) {
    auto builder = new InsertBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSelect(Json parsedSql) {
    auto builder = new SelectStatementBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSet(Json parsedSql) {
    auto builder = new SetBuilder();
    return builder.build(parsedSql);
  }

}

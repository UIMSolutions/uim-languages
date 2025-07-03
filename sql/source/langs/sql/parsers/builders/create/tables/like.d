module langs.sql.parsers.builders.create.tables.like;

import langs.sql;

@safe:

// Builds the LIKE statement part of a CREATE TABLE statement.
class LikeBuilder : ISqlBuilder {

    protected string buildTable(parsedSql, size_t anIndex) {
        auto myBuilder = new TableBuilder();
        return myBuilder.build(parsedSql, anIndex);
    }

    string build(Json parsedSql) {
        string mySql = this.buildTable(parsedSql, 0);
        if (mySql.isEmpty) {
            throw new UnableToCreateSQLException("LIKE", "", parsedSql, "table");
        }
        return "LIKE " ~ mySql;
    }
}

unittest {
  auto builder = new LikeBuilder;
  assert(builder, "Could not create LikeBuilder");
}
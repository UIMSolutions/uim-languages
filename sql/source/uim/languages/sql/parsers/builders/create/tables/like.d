module uim.languages.sql.parsers.builders.create.tables.like;

import uim.languages.sql;

@safe:

// Builds the LIKE statement part of a CREATE TABLE statement.
class LikeBuilder : DSqlBuilder {

    protected string buildTable(parsedSql, size_t anIndex) {
        auto builder = new TableBuilder();
        return builder.build(parsedSql, anIndex);
    }

    override string build(Json parsedSql) {
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
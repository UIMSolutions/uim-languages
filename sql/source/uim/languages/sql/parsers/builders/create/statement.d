module uim.languages.sql.parsers.builders.create.statement;

import uim.languages.sql;

@safe:
// Builds the CREATE statement 
class CreateStatementBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        string mySql = this.buildCreate(parsedSql);

       mySql ~= parsedSql.isSet("LIKE") ? " " ~ this.buildLike(parsedSql["LIKE"]) : "";
       mySql ~= parsedSql.isSet("SELECT") ? " " ~ this.buildSelectStatement(parsedSql) : "";

        return mySql;
    }

    protected string buildLike(Json parsedSql) {
        auto builder = new LikeBuilder();
        return builder.build(parsedSql);
    }

    protected string buildSelectStatement(Json parsedSql) {
        auto builder = new SelectStatementBuilder();
        return builder.build(parsedSql);
    }

    protected string buildCreate(Json parsedSql) {
        auto builder = new DCreateSqlBuilder();
        return builder.build(parsedSql);
    }
}

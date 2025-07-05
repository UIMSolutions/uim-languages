module uim.languages.sql.parsers.builders.update.updatestatement;
import uim.languages.sql;

@safe:
// Builds the UPDATE statement 
class UpdateStatementBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        string mySql = this.buildUPDATE(parsedSql["UPDATE"]) ~ " " ~ this.buildSET(
            parsedSql["SET"]);
        if ("WHERE" in parsedSql["WHERE"]) {
           mySql ~= " " ~ this.buildWhere(parsedSql["WHERE"]);
        }
        return mySql;
    }

    protected string buildWhere(Json parsedSql) {
        auto builder = new WhereBuilder();
        return builder.build(parsedSql);
    }

    protected string buildSET(Json parsedSql) {
        auto builder = new SetBuilder();
        return builder.build(parsedSql);
    }

    protected string buildUPDATE(Json parsedSql) {
        auto builder = new UpdateBuilder();
        return builder.build(parsedSql);
    }
}

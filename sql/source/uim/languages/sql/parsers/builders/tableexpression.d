module uim.languages.sql.parsers.builders.tableexpression;

import uim.languages.sql;

@safe:

// Builds the table name/join options. 
class TableExpressionBuilder : DSqlBuilder {

    override string build(Json parsedSql, size_t index = 0) {
        if (!parsedSql.isExpressionType("TABLE_EXPRESSION")) {
            return "";
        }

        string mySql = subString(this.buildFrom(parsedSql["sub_tree"]), 5); // remove FROM keyword
       mySql = "(" ~ mySql ~ ")";
       mySql ~= this.buildAlias(parsedSql);

        if (index != 0) {
           mySql = this.buildJoin(parsedSql["join_type"]) ~ mySql;
           mySql ~= this.buildRefType(parsedSql["ref_type"]);
           mySql ~= parsedSql["ref_clause"].isEmpty ? "" : this.buildRefClause(
                parsedSql["ref_clause"]);
        }
        return mySql;
    }

    protected string buildFrom(Json parsedSql) {
        auto builder = new FromBuilder();
        return builder.build(parsedSql);
    }

    protected string buildAlias(Json parsedSql) {
        auto builder = new AliasBuilder();
        return builder.build(parsedSql);
    }

    protected string buildJoin(Json parsedSql) {
        auto builder = new JoinBuilder();
        return builder.build(parsedSql);
    }

    protected string buildRefType(Json parsedSql) {
        auto builder = new RefTypeBuilder();
        return builder.build(parsedSql);
    }

    protected string buildRefClause(Json parsedSql) {
        auto builder = new RefClauseBuilder();
        return builder.build(parsedSql);
    }
}

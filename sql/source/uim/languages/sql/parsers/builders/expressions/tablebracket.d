module uim.languages.sql.parsers.builders.tablebracketexpression;

import uim.languages.sql;

@safe:

// Builds the table expressions within the create definitions of CREATE TABLE. 
class TableBracketExpressionBuilder : DSqlBuilder {



    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("BRACKET_EXPRESSION")) {
            return "";
        }
        string mySql = parsedSql["sub_tree"].byKeyValue
            .map!(kv => buildKeyValue(kv.key, kv.value))
            .join;

       mySql = " (" ~ subString(mySql, 0, -2) ~ ")";
        return mySql;
    }

    protected string buildKeyValue(string aKey, Json aValue) {
        string result;

        result ~= this.buildColDef(aValue);
        result ~= this.buildPrimaryKey(aValue);
        result ~= this.buildCheck(aValue);
        result ~= this.buildLikeExpression(aValue);
        result ~= this.buildForeignKey(aValue);
        result ~= this.buildIndexKey(aValue);
        result ~= this.buildUniqueIndex(aValue);
        result ~= this.buildFulltextIndex(aValue);

        if (result.isEmpty) { // No change
            throw new UnableToCreateSQLException("CREATE TABLE create-def expression subtree", aKey, aValue, "expr_type");
        }

        result ~= ", ";
        return result;
    }

        protected string buildColDef(Json parsedSql) {
        auto builder = new ColumnDefinitionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildPrimaryKey(Json parsedSql) {
        auto builder = new PrimaryKeyBuilder();
        return builder.build(parsedSql);
    }

    protected string buildForeignKey(Json parsedSql) {
        auto builder = new ForeignKeyBuilder();
        return builder.build(parsedSql);
    }

    protected string buildCheck(Json parsedSql) {
        auto builder = new CheckBuilder();
        return builder.build(parsedSql);
    }

    protected string buildLikeExpression(Json parsedSql) {
        auto builder = new LikeExpressionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildIndexKey(Json parsedSql) {
        auto builder = new IndexKeyBuilder();
        return builder.build(parsedSql);
    }

    protected string buildUniqueIndex(Json parsedSql) {
        auto builder = new UniqueIndexBuilder();
        return builder.build(parsedSql);
    }

    protected string buildFulltextIndex(Json parsedSql) {
        auto builder = new FulltextIndexBuilder();
        return builder.build(parsedSql);
    }
}

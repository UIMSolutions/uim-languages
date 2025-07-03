module langs.sql.parsers.builders.having;

import langs.sql;

@safe:

/**
 * Builds the HAVING part.
 * This class : the builder for the HAVING part. 
 */
class HavingBuilder : WhereBuilder {

    string build(Json parsedSql) {
        string mySql = "HAVING ";
        foreach (myKey, myValue; parsedSql) {
            size_t oldSqlLength = mySql.length;

           mySql ~= this.buildAliasReference(myValue);
           mySql ~= this.buildOperator(myValue);
           mySql ~= this.buildConstant(myValue);
           mySql ~= this.buildColRef(myValue);
           mySql ~= this.buildSubQuery(myValue);
           mySql ~= this.buildInList(myValue);
           mySql ~= this.buildFunction(myValue);
           mySql ~= this.buildHavingExpression(myValue);
           mySql ~= this.buildHavingBracketExpression(myValue);
           mySql ~= this.buildUserVariable(myValue);

            if (mySql.length == oldSqlLength) {
                throw new UnableToCreateSQLException("HAVING", myKey, myValue, "expr_type");
            }

           mySql ~= " ";
        }
        return substr(mySql, 0, -1);
    }

    protected string buildKeyValue(string aKey, Json aValue) {
        string result;
        return result;
    }

    protected string buildAliasReference(Json parsedSql) {
        auto myBuilder = new AliasReferenceBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildHavingExpression(Json parsedSql) {
        auto myBuilder = new HavingExpressionBuilder();
        return myBuilder.build(parsedSql);
    }

    protected string buildHavingBracketExpression(Json parsedSql) {
        auto myBuilder = new HavingBracketExpressionBuilder();
        return myBuilder.build(parsedSql);
    }
}

module uim.languages.sql.parsers.builders;

import uim.languages.sql;

@safe:

// Builds auto statements. 
class FunctionBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("AGGREGATE_FUNCTION")
            && parsedSql.isExpressionType("SIMPLE_FUNCTION")
            && parsedSql.isExpressionType("CUSTOM_FUNCTION")) {
            return "";
        }

        if (parsedSql["sub_tree"].isEmpty) {
            return parsedSql.baseExpression ~ "()" ~ this.buildAlias(parsedSql);
        }

        string result = parsedSql["sub_tree"].byKeyValue
            .map!(kv => buildKeyValue(kv.key, kv.value))
            .join;

        return parsedSql.baseExpression ~ "(" ~ subString(result, 0, -1)
            ~ ")" ~ this.buildAlias(
                parsedSql);
    }

    string buildKeyValue(string aKey, Json aValue) {
        string result;
        result ~= this.build(aValue);
        result ~= this.buildConstant(aValue);
        result ~= this.buildSubQuery(aValue);
        result ~= this.buildColRef(aValue);
        result ~= this.buildReserved(aValue);
        result ~= this.buildSelectBracketExpression(aValue);
        result ~= this.buildSelectExpression(aValue);
        result ~= this.buildUserVariableExpression(aValue);
        if (result.isEmpty) { // No change
            throw new UnableToCreateSQLException("auto subtree", myKey, aValue, "expr_type");
        }

        result ~= (this.isReserved(myValue) ? " " : ",");
        return result;
    }

    protected string buildAlias(Json parsedSql) {
        auto builder = new AliasBuilder();
        return builder.build(parsedSql);
    }

    protected string buildColRef(Json parsedSql) {
        auto builder = new ColumnReferenceBuilder();
        return builder.build(parsedSql);
    }

    protected string buildConstant(Json parsedSql) {
        auto builder = new ConstantBuilder();
        return builder.build(parsedSql);
    }

    protected string buildReserved(Json parsedSql) {
        auto builder = new ReservedBuilder();
        return builder.build(parsedSql);
    }

    protected auto isReserved(Json parsedSql) {
        auto builder = new ReservedBuilder();
        return builder.isReserved(parsedSql);
    }

    protected string buildSelectExpression(Json parsedSql) {
        auto builder = new SelectExpressionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildSelectBracketExpression(Json parsedSql) {
        auto builder = new SelectBracketExpressionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildSubQuery(Json parsedSql) {
        auto builder = new SubQueryBuilder();
        return builder.build(parsedSql);
    }

    protected string buildUserVariableExpression(Json parsedSql) {
        auto builder = new UserVariableBuilder();
        return builder.build(parsedSql);
    }

}

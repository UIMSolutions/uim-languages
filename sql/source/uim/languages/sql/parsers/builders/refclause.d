module uim.languages.sql.parsers.builders.refclause;

import uim.languages.sql;

@safe:

/**
 * Builds reference clauses within a JOIN.
 * This class : the references clause within a JOIN.
 */
class RefClauseBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (parsedSql.isEmpty) {
            return "";
        }

        string mySql = parsedSql.byKeyValue
            .map!(kv => buildKeyValue(kv.key, kv.value))
            .join;

        return subString(mySql, 0, -1);
    }

    protected string buildKeyValue(string aKey, Json aValue) {
        string result;
        result ~= this.buildColRef(aValue);
        result ~= this.buildOperator(aValue);
        result ~= this.buildConstant(aValue);
        result ~= this.buildFunction(aValue);
        result ~= this.buildBracketExpression(aValue);
        result ~= this.buildInList(aValue);
        result ~= this.buildColumnList(aValue);
        result ~= this.buildSubQuery(aValue);

        if (result.isEmpty) { // No change
            throw new UnableToCreateSQLException("expression ref_clause", aKey, aValue, "expr_type");
        }

        result ~= " ";
        return result;
    }

    protected string buildInList(Json parsedSql) {
        auto builder = new InListBuilder();
        return builder.build(parsedSql);
    }

    protected string buildColRef(Json parsedSql) {
        auto builder = new ColumnReferenceBuilder();
        return builder.build(parsedSql);
    }

    protected string buildOperator(Json parsedSql) {
        auto builder = new OperatorBuilder();
        return builder.build(parsedSql);
    }

    protected string buildFunction(Json parsedSql) {
        auto builder = new FunctionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildConstant(Json parsedSql) {
        auto builder = new ConstantBuilder();
        return builder.build(parsedSql);
    }

    protected string buildBracketExpression(Json parsedSql) {
        auto builder = new SelectBracketExpressionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildColumnList(Json parsedSql) {
        auto builder = new ColumnListBuilder();
        return builder.build(parsedSql);
    }

    protected string buildSubQuery(Json parsedSql) {
        auto builder = new SubQueryBuilder();
        return builder.build(parsedSql);
    }
}

module uim.languages.sql.parsers.builders.create.tables.options;

import uim.languages.sql;

@safe:

// Builds the table-options statement part of CREATE TABLE.
class CreateTableOptionsBuilder : DSqlBuilder {

    /**
     * Returns a well-formatted delimiter string. If you don"t need nice SQL,
     * you could simply return parsedSql["delim"].
     * 
     * @param Json parsedSql The part of the output array, which contains the current expression.
     * @return a string, which is added right after the expression
     */
    protected auto getDelimiter(Json parsedSql) {
        return (parsedSql["delim"].isEmpty ? "" : (parsedSql["delim"])~" ").strip;
    }

    override string build(Json parsedSql) {
        if (!isset(parsedSql["options"]) || parsedSql["options"].isEmpty) {
            return "";
        }
        myoptions = parsedSql["options"];
        string mySql = "";
        foreach (myKey, myValue; myoptions) {
            size_t oldSqlLength = mySql.length;
           mySql ~= this.buildExpression(myValue);
           mySql ~= this.buildCharacterSet(myValue);
           mySql ~= this.buildCollation(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("CREATE TABLE options", myKey, myValue, "expr_type");
            }

           mySql ~= this.getDelimiter(myValue);
        }
        return " " ~ subString(mySql, 0, -1);
    }

    protected string buildExpression(Json parsedSql) {
        auto builder = new SelectExpressionBuilder();
        return builder.build(parsedSql);
    }

    protected string buildCharacterSet(Json parsedSql) {
        auto builder = new CharacterSetBuilder();
        return builder.build(parsedSql);
    }

    protected string buildCollation(Json parsedSql) {
        auto builder = new CollationBuilder();
        return builder.build(parsedSql);
    }

}

unittest {
  auto builder = new CreateTableOptionsBuilder;
  assert(builder, "Could not create CreateTableOptionsBuilder");
}
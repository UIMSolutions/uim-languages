module uim.languages.sql.parsers.builders.replacecolumnlist;
import uim.languages.sql;

@safe:

/*alias Alias = ;*/

// Builds column-list parts of REPLACE statements. 
class ReplaceColumnListBuilder : DSqlBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isExpressionType("COLUMN_LIST")) {
            return "";
        }

        string mySql = "";
        foreach (myKey, myValue; parsedSql["sub_tree"]) {
            size_t oldSqlLength = mySql.length;
           mySql ~= this.buildColumn(myValue);

            if (oldSqlLength == mySql.length) { // No change
                throw new UnableToCreateSQLException("REPLACE column-list subtree", myKey, myValue, "expr_type");
            }

           mySql ~= ", ";
        }
        return "(" ~ subString(mySql, 0, -2) ~ ")";
    }

    protected string buildColumn(Json parsedSql) {
        auto builder = new ColumnReferenceBuilder();
        return builder.build(parsedSql);
    }
}

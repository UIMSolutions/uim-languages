 module uim.languages.sql.parsers.builders;
 
 import uim.languages.sql;
 
 @safe:
 
 /**
 * Builds the LIMIT statement.
 * This class : the builder LIMIT statement. 
 */
class LimitBuilder : ISqlBuilder {

    string build(Json parsedSql) {
       mySql = (parsedSql["rowcount"]) . (parsedSql["offset"] ? " OFFSET " . parsedSql["offset"] : "");
        if (mySql.isEmpty) {
            throw new UnableToCreateSQLException("LIMIT", "rowcount", parsedSql, "rowcount");
        }
        return "LIMIT " ~ mySql;
    }
}

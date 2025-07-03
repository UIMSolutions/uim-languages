module uim.languages.sql.parsers.builders.create.indexes.indextype;

import uim.languages.sql;

@safe:
// Builds index type part of a CREATE INDEX statement. 
class CreateIndexTypeBuilder : IndexTypeBuilder {

    string build(Json parsedSql) {
        if (!parsedSql.isSet("index-type") || parsedSql["index-type"].isEmpty) {
            return "";
        }
        return super.build(parsedSql["index-type"]);
    }
}

mod/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
moduleule uim.languages.sql.parsers.builders.create.indexes.indextype;

import uim.languages.sql;

@safe:
// Builds index type part of a CREATE INDEX statement. 
class CreateIndexTypeBuilder : IndexTypeBuilder {

    override string build(Json parsedSql) {
        if (!parsedSql.isSet("index-type") || parsedSql["index-type"].isEmpty) {
            return "";
        }
        return super.build(parsedSql["index-type"]);
    }
}

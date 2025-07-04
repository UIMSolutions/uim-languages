/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.builders.create.indexes.indextable;

import uim.languages.sql;

@safe:
// Builds the table part of a CREATE INDEX statement
class CreateIndexTableBuilder : DSqlBuilder {

    string build(Json parsedSql) {
        if (parsedSql.isSet("on") || parsedSql["on"].isEmpty) {
            return "";
        }
        auto tableSql = parsedSql["on"];
        if (!tableSql.isExpressionType("TABLE")) {
            return "";
        }
        return "ON %s %s".format(tableSql["name"], this.buildColumnList(tableSql["sub_tree"]));
    }

    protected string buildColumnList(Json parsedSql) {
        auto myBuilder = new ColumnListBuilder();
        return myBuilder.build(parsedSql);
    }
}

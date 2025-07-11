﻿/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.tables.dropcolumn;

import uim.languages.sql;

@safe:
class DSQLDropColumn : DSQLUpdateStatement {
	this() {
		super();
	}

	this(string aTableName) {
		this();
		_tableName = aTableName;
	}

	this(string aTableName, string aColumnName) {
		this(aTableName);
		_columnName = aColumnName;
	}

	mixin(TProperty!("string", "tableName"));
	mixin(TProperty!("string", "columnName"));

	override string toSQL() {
		return "ALTER %s DROP COLUMN %s".format(_tableName, _columnName);
	}
}

auto SQLDropColumn() {
	return new DSQLDropColumn;
}

auto SQLDropColumn(string aTableName) {
	return new DSQLDropColumn(aTableName);
}

auto SQLDropColumn(string aTableName, string aColumnName) {
	return new DSQLDropColumn(aTableName, aColumnName);
}

unittest {
	writeln("Testing ", __MODULE__);
}

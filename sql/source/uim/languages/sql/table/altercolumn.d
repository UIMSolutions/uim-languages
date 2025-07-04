/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.tables.altercolumn;

import uim.languages.sql;

@safe:

// ALTER TABLE table_name ADD column_name datatype; 
// ALTER TABLE table_name DROP COLUMN column_name; 
// ALTER TABLE table_name RENAME COLUMN old_name to new_name; 
// SQL Server / Access : ALTER TABLE table_name ALTER COLUMN column_name datatype; 
// MySQL, Oracle (<10G): ALTER TABLE table_name MODIFY COLUMN column_name datatype; 
// Oracke (10G...) ALTER TABLE table_name MODIFY column_name datatype; 
class DSQLAlterColumn : DSQLUpdateStatement {
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

	this(string aTableName, string aColumnName, string aColumnDefinition) {
		this(aTableName, aColumnName);
		_columnDefinition = aColumnDefinition;
	}

	mixin(TProperty!("string", "tableName"));
	mixin(TProperty!("string", "columnName"));
	mixin(TProperty!("string", "columnDefinition"));

	O column(this O)(string name, string definition) {
		_columnName = name;
		_columnDefinition = definition;
		return cast(O) this;
	}

	override string toSQL() {
		return "ALTER %s ALTER COLUMN %s %s".format(_tableName, _columnName, _columnDefinition);
	}
}

auto SQLAlterColumn() {
	return new DSQLAlterColumn;
}

auto SQLAlterColumn(string aTableName) {
	return new DSQLAlterColumn(aTableName);
}

auto SQLAlterColumn(string aTableName, string aColumnName) {
	return new DSQLAlterColumn(aTableName, aColumnName);
}

auto SQLAlterColumn(string aTableName, string aColumnName, string aColumnDefinition) {
	return new DSQLAlterColumn(aTableName, aColumnName, aColumnDefinition);
}

unittest {
	writeln("Testing ", __MODULE__);

	assert(SQLAlterColumn("xxx", "yyy", "zzz") == "ALTER xxx ALTER COLUMN yyy zzz");
	assert(SQLAlterColumn
			.tableName("xxx")
			.columnName("yyy")
			.columnDefinition("zzz") == "ALTER xxx ALTER COLUMN yyy zzz");
	assert(SQLAlterColumn
			.tableName("xxx")
			.column("yyy", "zzz") == "ALTER xxx ALTER COLUMN yyy zzz");
}

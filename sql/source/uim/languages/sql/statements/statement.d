/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.statements.statement;

import uim.languages.sql;

@safe:
class DSQLStatement {
	this() {}

	override bool opEquals(Object value) {
		return super.opEquals(value);
	}
	bool opEquals(string value) {
		return toString == value;
	}

	string toSQL() { return ""; }
	override string toString() { return toSQL; }
}
auto SQLStatement() { return new DSQLStatement; }

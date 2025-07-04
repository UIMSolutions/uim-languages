/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.statements.update;

import uim.languages.sql;

@safe:
class DSQLUpdateStatement : DSQLStatement {
	this() {
	}
}

auto SQLUpdateStatement() {
	return new DSQLUpdateStatement;
}

unittest {
	writeln("Testing ", __MODULE__);

	auto statement = SQLUpdateStatement;
}

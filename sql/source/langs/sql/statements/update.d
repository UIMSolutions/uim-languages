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

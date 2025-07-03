module uim.languages.sql.statements.query;

import uim.languages.sql;

@safe:
class DSQLQueryStatement : DSQLStatement {
	this() {}
}
auto SQLQueryStatement() { return new DSQLQueryStatement; }


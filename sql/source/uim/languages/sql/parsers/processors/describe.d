module uim.languages.sql.parsers.processors.describe;

import uim.languages.sql;

@safe:
// This class processes the DESCRIBE statements.
class DescribeProcessor : ExplainProcessor {
    protected auto isStatement(someKeys, string aNeedle = "DESCRIBE") {
        return super.isStatement(someKeys, aNeedle);
    }
}

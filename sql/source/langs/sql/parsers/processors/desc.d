module uim.languages.sql.parsers.processors.desc;

import uim.languages.sql;

@safe:
// This class processes the DESC statement.
class DescProcessor : ExplainProcessor {
    protected auto isStatement(myKeys, string aNeedle = "DESC") {
        return super.isStatement(myKeys, aNeedle);
    }
}

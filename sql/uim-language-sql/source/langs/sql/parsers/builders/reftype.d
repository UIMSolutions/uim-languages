module langs.sql.parsers.builders;

import langs.sql;

@safe:

// Builds reference type within a JOIN. 
class RefTypeBuilder {

    string build(Json parsedSql) {
        if (parsedSql.isEmpty) {
            return null;
        }
        if (parsedSql == "ON") {
            return " ON ";
        }
        if (parsedSql == "USING") {
            return " USING ";
        }
        // TODO: add more
        throw new UnsupportedFeatureException(parsedSql);
    }
}

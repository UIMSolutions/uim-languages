/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.utils;

import uim.languages.sql;

@safe:

public {
    import uim.languages.sql.parsers.utils.expressiontype;
    import uim.languages.sql.parsers.utils.expressiontoken;
    import uim.languages.sql.parsers.utils.parserconstants;
}

// Minimal stub for isNumeric
bool isNumeric(string s) {
    import std.conv : to;
    import std.exception : ConvException;

    if (s.length == 0)
        return false;
    try {
        s.to!double;
        return true;
    } catch (ConvException) {
        return false;
    }
}


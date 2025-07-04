/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.interfaces.processor;

import uim.languages.sql;

@safe:

interface IProcessor {
    /**
     * This auto : the main functionality of a processor class.
     * Always use default valuses for additional parameters within overridden functions.
     */
    Json process(string[] tokens);

    // this auto splits up a SQL statement into easy to "parse" tokens for the SQL processor
    auto splitSQLIntoTokens(string sqlString);

    // Json processComment(myexpression);

    // translates an array of objects into an associative array
    // auto toArray(mytokenList);
}

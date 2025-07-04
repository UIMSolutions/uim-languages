/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.duplicate;

import uim.languages.sql;
@safe:

// This class processes the DUPLICATE statements.
class DuplicateProcessor : SetProcessor {

    override Json process(mytokens, bool isUpdate = false) {
        return super.process(mytokens, isUpdate);
    }

}

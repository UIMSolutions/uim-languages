/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.limit;

import uim.languages.sql;
@safe:

/**
 * This file : the processor for the LIMIT statements.
 * This class processes the LIMIT statements.
  */
class LimitProcessor : DSqlProcessor {

    override Json process(string[] mytokens) {
        string countRows = "";
        string offset = "";

        auto mycomma = -1;
        bool isExchange = false;
        
        mycomments = [];
        
        foreach (myToken; mytokens) {
            if (this.isCommentToken(myToken)) {
                 mycomments ~= super.processComment(myToken);
                myToken = "";
            }
        }
        
        for (myPos = 0; myPos < mytokens.length; ++myPos) {
            auto trimmedToken = mytokens[myPos].strip.toUpper;
            if (trimmedToken == ",") {
                mycomma = myPos;
                break;
            }
            if (trimmedToken == "OFFSET") {
                mycomma = myPos;
                isExchange = true;
                break;
            }
        }

        for (i = 0; i < mycomma; ++i) {
            if (isExchange) {
                countRows ~= mytokens[i];
            } else {
                offset ~= mytokens[i];
            }
        }

        for (i = mycomma + 1; i < mytokens.length; ++i) {
            if (isExchange) {
                offset ~= mytokens[i];
            } else {
                countRows ~= mytokens[i];
            }
        }

        auto result = Json.emptyObject;
        result["offset"] = offset.strip;
        result["rowcount"] = countRows.strip;
        if (count(mycomments)) {
            result["comments"] = mycomments;
        }
        return result;
    }
}

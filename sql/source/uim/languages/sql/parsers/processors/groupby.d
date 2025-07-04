
/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.groupby;
import uim.languages.sql;

@safe:
// This class processes the GROUP-BY statements.
class GroupByProcessor : OrderByProcessor {

    Json process(tokens, myselect = []) {
        result = [];
        myparseInfo = this.initParseInfo();

        if (!tokens) {
            return false;
        }

        foreach (myToken; tokens) {
            auto strippedToken = myToken.strip.toUpper;
            switch (strippedToken) {
            case ",":
                myparsed = this.processOrderExpression(myparseInfo, myselect);
                unset(myparsed["direction"]);

                result ~= myparsed;
                myparseInfo = this.initParseInfo();
                break;
            default:
                myparseInfo.baseExpression ~= myToken;
                break;
            }
        }

        myparsed = this.processOrderExpression(myparseInfo, myselect);
        unset(myparsed["direction"]);
        result ~= myparsed;

        return result;
    }
}

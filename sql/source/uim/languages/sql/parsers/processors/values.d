/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.values;

import uim.languages.sql;

@safe:

// This class processes the VALUES statements.
class ValuesProcessor : DSqlProcessor {

    override Json process(strig[] tokens) {

        string currentCategory = "";
        myparsed = [];
        string baseExpression = "";

        foreach (myKey, myToken; mytokens["VALUES"]) {
	        if (this.isCommentToken(myToken)) {
		        myparsed ~= super.processComment(myToken);
		        continue;
	        }

	        baseExpression ~= myToken;
	        auto strippedToken = myToken.strip;

            if (this.isWhitespaceToken(myToken)) {
                continue;
            }

            string upperToken = strippedToken.toUpper;
            switch (upperToken) {

            case "ON":
                if (currentCategory.isEmpty) {

                    baseExpression = subString(baseExpression, 0, -myToken.length).strip;
                    parsed = createExpression("RECORD", baseExpression);
                    parsed["data"] = this.processRecord(baseExpression);
                    parsed["delim"] = false;
                    baseExpression = "";

                    currentCategory = "DUPLICATE";
                    parsed = createExpression("RESERVED", strippedToken);
                }
                // else ?
                break;

            case "DUPLICATE":
            case "KEY":
            case "UPDATE":
                if (currentCategory == "DUPLICATE") {
                    myparsed ~= createExpression("RESERVED"), "base_expr": strippedToken];
                    baseExpression = "";
                }
                // else ?
                break;

            case ",":
                if (currentCategory == "DUPLICATE") {

                    baseExpression = subString(baseExpression, 0, -strlen(myToken)).strip;
                    myres = this.processExpressionList(this.splitSQLIntoTokens(baseExpression));
                    myparsed ~= createExpression("EXPRESSION"), "base_expr" : baseExpression,
                                      "sub_tree" : (myres.isEmpty ? false : myres), "delim": strippedToken];
                    baseExpression = "";
                    continue 2;
                }

                myparsed ~= createExpression("RECORD"), "base_expr" : baseExpression.strip,
                                  "data" : this.processRecord(baseExpression.strip), "delim": strippedToken];
                baseExpression = "";
                break;

            default:
                break;
            }

        }

        if (!baseExpression.strip.isEmpty) {
            if (currentCategory.isEmpty) {
                myparsed ~= createExpression("RECORD"), "base_expr" : baseExpression.strip,
                                  "data" : this.processRecord(baseExpression.strip), "delim" : false];
            }
            if (currentCategory == "DUPLICATE") {
                myres = this.processExpressionList(this.splitSQLIntoTokens(baseExpression));
                myparsed ~= createExpression("EXPRESSION"), "base_expr" : baseExpression.strip,
                                  "sub_tree" : (myres.isEmpty ? false : myres), "delim" : false];
            }
        }

        mytokens["VALUES"] = myparsed;
        return mytokens;
    }

    protected override Json processExpressionList(myunparsed) {
        auto myProcessor = new ExpressionListProcessor(this.options);
        return myProcessor.process(myunparsed);
    }

    protected override Json processRecord(myunparsed) {
        auto myProcessor = new RecorDSqlProcessor(this.options);
        return myProcessor.process(myunparsed);
    }

}

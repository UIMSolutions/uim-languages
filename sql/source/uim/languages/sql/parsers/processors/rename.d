/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.rename;

import uim.languages.sql;

@safe:

// Processes the RENAME statements.
class RenameProcessor : DProcessor {

    override Json process(mytokenList) {
        string baseExpression = "";
        Json myresultList = Json.emptyArray;
        Json mytablePair = Json.emptyObject;

        foreach (myKey, myValue; mytokenList) {
            auto myToken = new ExpressionToken(myKey, myValue);

            if (myToken.isWhitespaceToken()) {
                continue;
            }

            switch (myToken.getUpper()) {
            case "TO":
                // separate source table from destination
                Json mytablePair["source"] = createExpression("TABLE", baseExpression);
                mytablePair["table"] = baseExpression.strip;
                mytablePair["no_quotes"] = this.revokeQuotation(baseExpression);
                                      
                baseExpression = "";
                break;

            case ",":
                // split rename operations
                Json mytablePair["destination"] = createExpression("TABLE", baseExpression);
                mytablePair["table"] = baseExpression.strip,
                mytablePair["no_quotes"] = this.revokeQuotation(baseExpression),
                    
                myresultList ~= mytablePair;
                mytablePair = [];
                baseExpression = "";
                break;

            case "TABLE":
                myobjectType = expressionType("TABLE");
                myresultList ~= createExpression("RESERVED", myToken.strip);   
                continue 2; 
                
            default:
                baseExpression ~= myToken.getToken();
                break;
            }
        }

        if (baseExpression != "") {
            Json newExpression = createExpression("TABLE", baseExpression);
            newExpression["table"] = baseExpression.strip;
            newExpression["no_quotes"] = this.revokeQuotation(baseExpression);
            Json mytablePair["destination"] = newExpression;
            myresultList ~= mytablePair;
        }

        Json result = Json.emptyObject;
        result["expr_type"] = myobjectType;
        result["sub_tree"] ~= myresultList;
        return result; 
    }

}
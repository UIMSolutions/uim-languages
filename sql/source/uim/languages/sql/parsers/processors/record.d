/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.processors.record;

import uim.languages.sql;

@safe:
// This class processes records of an INSERT statement.
class RecordProcessor : DProcessor {

  protected override Json processExpressionList(Json unparsed) {
    auto myProcessor = new ExpressionListProcessor(this.options);
    return myProcessor.process(unparsed);
  }

  override Json process(Json unparsed) {
    auto unparsedCorrected = this.removeParenthesisFromStart(unparsed);
    auto myTokens = this.splitSQLIntoTokens(unparsedCorrected);

   myTokens.byKeyValue
      .filter!(kv => this.isCommaToken(kv.value))
      .each!(kv => myTokens[kv.key] = "");

    return this.processExpressionList(myTokens);
  }
}

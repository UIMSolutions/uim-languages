module langs.sql.parsers.processors.record;

import langs.sql;

@safe:
// This class processes records of an INSERT statement.
class RecordProcessor : Processor {

  protected Json processExpressionList(Json unparsed) {
    auto myProcessor = new ExpressionListProcessor(this.options);
    return myProcessor.process(unparsed);
  }

  Json process(Json unparsed) {
    auto unparsedCorrected = this.removeParenthesisFromStart(unparsed);
    auto myTokens = this.splitSQLIntoTokens(unparsedCorrected);

   myTokens.byKeyValue
      .filter!(kv => this.isCommaToken(kv.value))
      .each!(kv => myTokens[kv.key] = "");

    return this.processExpressionList(myTokens);
  }
}

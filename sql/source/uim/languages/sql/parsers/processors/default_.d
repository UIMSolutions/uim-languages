module uim.languages.sql.parsers.processors.default_;

import uim.languages.sql;

@safe:

// This class processes the incoming sql string.
class DefaultProcessor : DSqlProcessor {

  protected auto isUnion(mytokens) {
    return UnionProcessor::isUnion(mytokens);
  }

  protected override Json processUnion(mytokens) {
    // this is the highest level lexical analysis. This is the part of the
    // code which finds UNION and UNION ALL query parts
    auto processor = new UnionProcessor(this.options);
    return processor.process(strig[] tokens);
  }

  protected override Json processSQL(mytokens) {
    auto processor = new SQLProcessor(this.options);
    return processor.process(strig[] tokens);
  }

  override Json process(mysql) {

    auto myInputArray = this.splitSQLIntoTokens(mysql);
    auto myQueries = this.processUnion(myInputArray);

    // If there was no UNION or UNION ALL in the query, then the query is
    // stored at myQueries[0].
    if (!myQueries.isEmpty && !this.isUnion(myQueries)) {
     myQueries = this.processSQL(myQueries[0]);
    }

    return myQueries;
  }

  auto revokeQuotation(mysql) {
    return super.revokeQuotation(mysql);
  }
}



?  > 
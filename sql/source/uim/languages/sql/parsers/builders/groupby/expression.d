module uim.languages.sql.parsers.builders.groupby.expression;

import uim.languages.sql;

@safe:

// Builds an expression within a GROUP-BY clause.
class GroupByExpressionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("EXPRESSION")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

   mySql = subString(mySql, 0, -1);
    return mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildColRef(aValue);
    result ~= this.buildReserved(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("GROUP expression subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

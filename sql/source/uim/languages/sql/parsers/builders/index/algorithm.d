module uim.languages.sql.parsers.builders.index.algorithm;

import uim.languages.sql;

@safe:

// Builds index algorithm part of a CREATE INDEX statement.
class IndexAlgorithmBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("INDEX_ALGORITHM")) {
      return null;
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildReserved(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildOperator(aValue);

    if (oldSqlLength == mySql.length) { // No change
      throw new UnableToCreateSQLException("CREATE INDEX algorithm subtree", aKey, aValue, "expr_type");
    }

    return result ~ " ";
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildOperator(Json parsedSql) {
    auto builder = new OperatorBuilder();
    return myBuilderr.build(parsedSql);
  }
}

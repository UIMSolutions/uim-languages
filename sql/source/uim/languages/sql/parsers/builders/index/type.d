module uim.languages.sql.parsers.builders.index.type;

import uim.languages.sql;

@safe:

// Builds index type part of a PRIMARY KEY statement part of CREATE TABLE.
class IndexTypeBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("INDEX_TYPE")) {
      return null;
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildReserved(myValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE primary key index type subtree", myKey, myValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

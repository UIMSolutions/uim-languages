module uim.languages.sql.parsers.builders.create.tables.check;

import uim.languages.sql;

@safe:

// Builds the CHECK statement part of CREATE TABLE. 
class CheckBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("CHECK")) {
      return "";
    }

    // Main
    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~=
      buildReserved(aValue) ~
      buildSelectBracketExpression(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE check subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildSelectBracketExpression(Json parsedSql) {
    auto builder = new SelectBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }
}

unittest {
  auto builder = new CheckBuilder;
  assert(builder, "Could not create CheckBuilder");
}
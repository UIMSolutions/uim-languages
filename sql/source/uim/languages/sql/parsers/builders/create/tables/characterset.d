module uim.languages.sql.parsers.builders.create.tables.characterset;

import uim.languages.sql;

@safe:

// Builds the CHARACTER SET part of a CREATE TABLE statement. 
class CharacterSetBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("CHARSET")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildOperator(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildConstant(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE options CHARACTER SET subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildOperator(Json parsedSql) {
    auto builder = new OperatorBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

}

unittest {
  auto builder = new CharacterSetBuilder;
  assert(builder, "Could not create CharacterSetBuilder");
}

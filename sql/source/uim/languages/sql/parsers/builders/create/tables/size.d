module uim.languages.sql.parsers.builders.create.tables.size;

import uim.languages.sql;

@safe:

// Builds index size part of a PRIMARY KEY statement part of CREATE TABLE.
class IndexSizeBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("INDEX_SIZE")) {
      return "";
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
    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE primary key index size subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }
}

unittest {
  auto builder = new IndexSizeBuilder;
  assert(builder, "Could not create IndexSizeBuilder");
}
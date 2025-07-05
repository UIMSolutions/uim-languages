module uim.languages.sql.parsers.builders.create.tables.fulltextindex;

import uim.languages.sql;

@safe:

// Builds index key part of a CREATE TABLE statement. 
class FulltextIndexBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("FULLTEXT_IDX")) {
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
    result ~= this.buildColumnList(aValue);
    result ~= this.buildConstant(aValue);
    result ~= this.buildIndexKey(aValue);

    if (result.isEmpty) { // No change aValue
      throw new UnableToCreateSQLException("CREATE TABLE fulltext-index key subtree", aKey, aValue, "expr_type");
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

  protected string buildIndexKey(Json parsedSql) {
    if (!parsedSql.isExpressionType("INDEX")) {
      return "";
    }

    return parsedSql.baseExpression;
  }

  protected string buildColumnList(Json parsedSql) {
    auto builder = new ColumnListBuilder();
    return builder.build(parsedSql);
  }
}

unittest {
  auto builder = new FulltextIndexBuilder;
  assert(builder, "Could not create FulltextIndexBuilder");
}
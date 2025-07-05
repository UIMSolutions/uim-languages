module uim.languages.sql.parsers.builders.create.tables.primarykey;

import uim.languages.sql;

@safe:

// Builds the PRIMARY KEY statement part of CREATE TABLE. 
class PrimaryKeyBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("PRIMARY_KEY")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildConstraint(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildColumnList(aValue);
    result ~= this.buildIndexType(aValue);
    result ~= this.buildIndexSize(aValue);
    result ~= this.buildIndexParser(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE primary key subtree", aKey, aValue, "expr_type");
    }

    mySql ~= " ";
    return result;
  }

  protected string buildColumnList(Json parsedSql) {
    auto builder = new ColumnListBuilder();
    return builder.build(parsedSql);
  }

  protected string buildConstraint(Json parsedSql) {
    auto builder = new ConstraintBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexType(Json parsedSql) {
    auto builder = new IndexTypeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexSize(Json parsedSql) {
    auto builder = new IndexSizeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexParser(Json parsedSql) {
    auto builder = new IndexParserBuilder();
    return builder.build(parsedSql);
  }
}

unittest {
  auto builder = new PrimaryKeyBuilder;
  assert(builder, "Could not create PrimaryKeyBuilder");
}
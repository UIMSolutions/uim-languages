module uim.languages.sql.parsers.builders.create.tables.foreignkey;

import uim.languages.sql;

@safe:

// Builds the FOREIGN KEY statement part of CREATE TABLE. 
class ForeignKeyBuilder : IBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("FOREIGN_KEY")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildConstant(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildColumnList(aValue);
    result ~= this.buildForeignRef(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE foreign key subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildColumnList(Json parsedSql) {
    auto builder = new ColumnListBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildForeignRef(Json parsedSql) {
    auto builder = new ForeignRefBuilder();
    return builder.build(parsedSql);
  }
}

unittest {
  auto builder = new ForeignKeyBuilder;
  assert(builder, "Could not create ForeignKeyBuilder");
}
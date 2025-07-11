module uim.languages.sql.parsers.builders.columns.definition;

import uim.languages.sql;

@safe:
// Builds the column definition statement part of CREATE TABLE. 
class ColumnDefinitionBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    // In Check
    if (!parsedSql.isExpressionType("COLDEF")) {
      return null;
    }

    // Main
    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildColRef(aValue);
    result ~= this.buildColumnType(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE primary key subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildColRef(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }

  protected string buildColumnType(Json parsedSql) {
    auto builder = new ColumnTypeBuilder();
    return builder.build(parsedSql);
  }

}

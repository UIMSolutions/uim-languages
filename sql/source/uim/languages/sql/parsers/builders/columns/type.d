module uim.languages.sql.parsers.builders.columns.type;

import uim.languages.sql;

@safe:

// Builds the column type statement part of CREATE TABLE. */
class ColumnTypeBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("COLUMN_TYPE")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    
    result ~= this.buildDataType(aValue);
    result ~= this.buildColumnTypeBracketExpression(aValue);
    result ~= this.buildReserved(aValue);
    result ~= this.buildDefaultValue(aValue);
    result ~= this.buildCharacterSet(aValue);
    result ~= this.buildCollation(aValue);
    result ~= this.buildComment(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE TABLE column-type subtree", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildColumnTypeBracketExpression(Json parsedSql) {
    auto builder = new ColumnTypeBracketExpressionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

  protected string buildDataType(Json parsedSql) {
    auto builder = new DataTypeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildDefaultValue(Json parsedSql) {
    auto builder = new DefaultValueBuilder();
    return builder.build(parsedSql);
  }

  protected string buildCharacterSet(Json parsedSql) {
    if (!parsedSql.isExpressionType("CHARSET")) {
      return "";
    }
    return parsedSql.baseExpression;
  }

  protected string buildCollation(Json parsedSql) {
    if (!parsedSql.isExpressionType("COLLATE")) {
      return "";
    }
    return parsedSql.baseExpression;
  }

  protected string buildComment(Json parsedSql) {
    if (!parsedSql.isExpressionType("COMMENT")) {
      return "";
    }
    return parsedSql.baseExpression;
  }
}

module uim.languages.sql.parsers.builders.drop.expression;

import uim.languages.sql;

@safe:
// Builds the object list of a DROP statement. 
class DropExpressionBuilder : DSqlBuilder {
  this() {
  }

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("EXPRESSION")) {
      return null;
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return subString(mySql, 0, -2);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildTable(aValue, 0);
    result ~= this.buildView(aValue);
    result ~= this.buildSchema(aValue);
    result ~= this.buildDatabase(aValue);
    result ~= this.buildTemporaryTable(aValue, 0);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("DROP object-list subtree", aKey, aValue, "expr_type");
    }

    result ~= ", ";
    return result;
  }

  protected string buildTable(Json parsedSql, long anIndex) {
    auto builder = new TableBuilder();
    return builder.build(parsedSql, anIndex);
  }

  protected string buildDatabase(Json parsedSql) {
    auto builder = new DatabaseBuilder();
    return builder.build(parsedSql);
  }

  protected string buildSchema(Json parsedSql) {
    auto builder = new SchemaBuilder();
    return builder.build(parsedSql);
  }

  protected string buildTemporaryTable(Json parsedSql) {
    auto builder = new TempTableBuilder();
    return builder.build(parsedSql);
  }

  protected string buildView(Json parsedSql) {
    auto builder = new ViewBuilder();
    return builder.build(parsedSql);
  }
}

module langs.sql.parsers.builders.drop.expression;

import langs.sql;

@safe:
// Builds the object list of a DROP statement. 
class DropExpressionBuilder : ISqlBuilder {
  this() {
  }

  string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("EXPRESSION")) {
      return null;
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return substr(mySql, 0, -2);
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
    auto myBuilder = new TableBuilder();
    return myBuilder.build(parsedSql, anIndex);
  }

  protected string buildDatabase(Json parsedSql) {
    auto myBuilder = new DatabaseBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildSchema(Json parsedSql) {
    auto myBuilder = new SchemaBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildTemporaryTable(Json parsedSql) {
    auto myBuilder = new TempTableBuilder();
    return myBuilder.build(parsedSql);
  }

  protected string buildView(Json parsedSql) {
    auto myBuilder = new ViewBuilder();
    return myBuilder.build(parsedSql);
  }
}

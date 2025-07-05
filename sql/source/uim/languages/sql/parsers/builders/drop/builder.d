module uim.languages.sql.parsers.builders.drop.builder;

import uim.languages.sql;

@safe:

// This class : the builder for the [DROP] part. */
class DropBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    auto dropSql = parsedSql["DROP"];
    string mySql = this.buildSubTree(dropSql);

    if (dropSql.isExpressionType("INDEX")) {
     mySql ~= "" ~ this.buildDropIndex(parsedSql["INDEX"]) ~ " ";
    }

    return "DROP " ~ subString(mySql, 0, -1);
  }

  protected string buildSubTree(Json parsedSql) {
    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.ley, kv.value))
      .join;

    return mySql;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildReserved(myValue);
    result ~= this.buildExpression(myValue);

    if (result.isEmpty) {
      throw new UnableToCreateSQLException("DROP subtree", myKey, myValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildDropIndex(Json parsedSql) {
    auto myBuilder = new DropIndexBuilder();

    return myBuilder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto myBuilder = new ReservedBuilder();

    return myBuilder.build(parsedSql);
  }

  protected string buildExpression(Json parsedSql) {
    auto myBuilder = new DropExpressionBuilder();

    return myBuilder.build(parsedSql);
  }
}

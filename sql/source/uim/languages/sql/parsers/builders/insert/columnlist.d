module uim.languages.sql.parsers.builders.insert.columnlist;

import uim.languages.sql;

@safe:

// Builds column-list parts of INSERT statements.
class InsertColumnListBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (!parsedSql.isExpressionType("COLUMN_LIST")) {
      return "";
    }

    string mySql = parsedSql["sub_tree"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return "(" ~ subString(mySql, 0, -2) ~ ")";
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildColumn(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("INSERT column-list subtree", aKey, aValue, "expr_type");
    }

    result ~= ", ";
    return result;
  }

  protected string buildColumn(Json parsedSql) {
    auto builder = new ColumnReferenceBuilder();
    return builder.build(parsedSql);
  }
}

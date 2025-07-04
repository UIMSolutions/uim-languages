/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.tables.delete_;

import uim.languages.sql;

@safe:
class DSQLDelete : DSQLStatement {
  this(string table = "", string condition = "") {
    from(table).where(condition);
  }

  this(string table, string[] conditions) {
    from(table).where(conditions);
  }

  protected string _table;
  auto from(string tableName) {
    return table(tableName);
  }

  auto table(string name) {
    if (name.length > 0)
      _table = name;
    return this;
  }

  protected string _where;
  auto where(string condition = "") {
    if (condition.length > 0)
      _where = condition;
    return this;
  }

  auto where(string[] conditions) {
    if (conditions.length > 0)
      _where = AND(conditions);
    return this;
  }

  auto clear() {
    _table = null;
    _where = null;
    return this;
  }

  override string toSQL() {
    auto sql = "DELETE FROM " ~ _table;
    if (_where.length > 0)
      sql ~= " WHERE " ~ _where;
    return sql;
  }

  override string toString() {
    return toSQL;
  }
}

auto SQLDelete(string table = "", string condition = "") {
  return new DSQLDelete(table, condition);
}

auto SQLDelete(string table, string[] conditions) {
  return new DSQLDelete(table, conditions);
}

unittest {
  writeln("Testing ", __MODULE__);

  assert(SQLDelete.table("tab") == "DELETE FROM tab");
  assert(SQLDelete("tab") == "DELETE FROM tab");
  assert(SQLDelete("tab", "(x > 1)") == "DELETE FROM tab WHERE (x > 1)");
  assert(SQLDelete("tab", ["(x > 1)", "(y > 2)"]) == "DELETE FROM tab WHERE ((x > 1)) AND ((y > 2))");
}

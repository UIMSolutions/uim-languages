module uim.languages.sql.parsers.builders.create.indexes.indexoptions;

import uim.languages.sql;

@safe:
// Builds index options part of a CREATE INDEX statement.
class CreateIndexOptionsBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    if (parsedSql.isEmpty("options")) {
      return null; // No options to build
    }

    string sql = parsedSql["options"].byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    return " " ~ subString(sql, 0, -1);
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;

    result ~= this.buildIndexAlgorithm(aValue);
    result ~= this.buildIndexLock(aValue);
    result ~= this.buildIndexComment(aValue);
    result ~= this.buildIndexParser(aValue);
    result ~= this.buildIndexSize(aValue);
    result ~= this.buildIndexType(aValue);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("CREATE INDEX options", aKey, aValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildIndexParser(Json parsedSql) {
    auto builder = new IndexParserBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexSize(Json parsedSql) {
    auto builder = new IndexSizeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexType(Json parsedSql) {
    auto builder = new IndexTypeBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexComment(Json parsedSql) {
    auto builder = new IndexCommentBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexAlgorithm(Json parsedSql) {
    auto builder = new IndexAlgorithmBuilder();
    return builder.build(parsedSql);
  }

  protected string buildIndexLock(Json parsedSql) {
    auto builder = new IndexLockBuilder();
    return builder.build(parsedSql);
  }
}

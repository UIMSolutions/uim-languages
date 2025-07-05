module uim.languages.sql.parsers.builders.show.show;

import uim.languages.sql;

@safe:

// Builds the SHOW statement. 
class ShowBuilder : DSqlBuilder {

  override string build(Json parsedSql) {
    auto showSql = parsedSql["SHOW"];

    string result = showSql.byKeyValue
      .map!(kv => buildKeyValue(kv.key, kv.value))
      .join;

    result = "SHOW " ~ subString(result, 0, -1);
    return result;
  }

  protected string buildKeyValue(string aKey, Json aValue) {
    string result;
    result ~= this.buildReserved(myValue);
    result ~= this.buildConstant(myValue);
    result ~= this.buildEngine(myValue);
    result ~= this.buildDatabase(myValue);
    result ~= this.buildProcedure(myValue);
    result ~= this.buildFunction(myValue);
    result ~= this.buildTable(myValue, 0);

    if (result.isEmpty) { // No change
      throw new UnableToCreateSQLException("SHOW", myKey, myValue, "expr_type");
    }

    result ~= " ";
    return result;
  }

  protected string buildTable(Json parsedSql, string delim) {
    auto builder = new TableBuilder();
    return builder.build(parsedSql, delim);
  }

  protected string buildFunction(Json parsedSql) {
    auto builder = new FunctionBuilder();
    return builder.build(parsedSql);
  }

  protected string buildProcedure(Json parsedSql) {
    auto builder = new ProcedureBuilder();
    return builder.build(parsedSql);
  }

  protected string buildDatabase(Json parsedSql) {
    auto builder = new DatabaseBuilder();
    return builder.build(parsedSql);
  }

  protected string buildEngine(Json parsedSql) {
    auto builder = new EngineBuilder();
    return builder.build(parsedSql);
  }

  protected string buildConstant(Json parsedSql) {
    auto builder = new ConstantBuilder();
    return builder.build(parsedSql);
  }

  protected string buildReserved(Json parsedSql) {
    auto builder = new ReservedBuilder();
    return builder.build(parsedSql);
  }

}

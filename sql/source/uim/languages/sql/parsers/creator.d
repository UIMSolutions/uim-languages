/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.sql.parsers.sqlcreator;

import uim.languages.sql;

@safe:

// A creator, which generates SQL from the output of SqlParser.
class SqlCreator {

  string _createdSql;

  this(Json aParsed = json(null)) {
    if (!aParsed.isNull) {
      this.create(aParsed);
    }
  }

  string create(Json aParsed) {
    string myKey = key(aParsed);
    switch (myKey) {
      case "UNION":
        auto builder = new UnionStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "UNION ALL":
        auto builder = new UnionAllStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "SELECT":
        auto builder = new SelectStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "INSERT":
        auto builder = new InsertStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "REPLACE":
        auto builder = new ReplaceStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "DELETE":
        auto builder = new DeleteStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "TRUNCATE":
        auto builder = new TruncateStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "UPDATE":
        auto builder = new UpdateStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "RENAME":
        auto builder = new RenameStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "SHOW":
        auto builder = new ShowStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "CREATE":
        auto builder = new CreateStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "BRACKET":
        auto builder = new BracketStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "DROP":
        auto builder = new DropStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      case "ALTER":
        auto builder = new AlterStatementBuilder();
        _createdSql = builder.build(aParsed);
        break;
      default:
        throw new UnsupportedFeatureException(myKey);
        break;
    }
    return _createdSql;
  }
}

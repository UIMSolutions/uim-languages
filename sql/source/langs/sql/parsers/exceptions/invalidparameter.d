module langs.sql.parsers.exceptions.invalidparameter;

import langs.sql;

@safe:

// This exception will occur in the parser, if the given SQL statement is not a String type. 
class InvalidParameterException : InvalidArgumentException {

  protected string _argument;

  this(string anArgument) {
    auto _argument = anArgument;
    super("no SQL string to parse: \n" ~ _argument); //, 10);
  }

  auto argument() {
    return _argument;
  }
}

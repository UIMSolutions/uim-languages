/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.python.parsers;

import uim.languages.python;
@safe:

auto parse(string content) {
  auto isComment = (string line) => line.startsWith('#');
  auto isSignificant = (string line) => !line.empty && !isComment(line);

  return content
  .splitter('\n')
  .map!strip
  .filter!isSignificant
  .array;
}
unittest {
  writeln("XXX");
  writeln(parse(`var1 = "Die Antwort ist"
print(var1)
var1 = 42
print(var1)`));
}
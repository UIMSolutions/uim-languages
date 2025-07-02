module uim.languages.python.parser;

import uim.languages.python;

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
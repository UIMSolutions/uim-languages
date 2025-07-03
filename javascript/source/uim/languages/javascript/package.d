module uim.languages.javascript;

// Local packages
public {
    import uim.language;
    import uim.languages.javascript.functions;
    import uim.languages.javascript.classes;
    import uim.languages.javascript.tools;
    import uim.languages.javascript.error;
    import uim.languages.javascript.conditional;
}

// JavaScript code generation functions
auto jsEvent(string target, string event, string listener) {
  return "%s.addEventListener(%s, %s);".format(target, event, listener);
}

auto jsReturn(string result) {
  return "return "~result~";";
}

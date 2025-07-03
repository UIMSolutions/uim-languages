module uim.languages.javascript;

mixin(ImportPhobos!());

// Dub libraries
public import vibe.d;

// UIM libraries
public import uim.core;
public import uim.oop;

// Local packages
public import uim.languages.javascript.functions;
public import uim.languages.javascript.classes;
public import uim.languages.javascript.tools;
public import uim.languages.javascript.error;
public import uim.languages.javascript.conditional;

auto jsEvent(string target, string event, string listener) {
  return "%s.addEventListener(%s, %s);".format(target, event, listener);
}

auto jsReturn(string result) {
  return "return "~result~";";
}

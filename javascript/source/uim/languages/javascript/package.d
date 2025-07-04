/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.javascript;

// Local packages
public {
  // Importing all necessary modules for the JavaScript language support
  import uim.language;

  // Importing the JavaScript language module
  import uim.languages.javascript.classes;
  import uim.languages.javascript.conditional;
  import uim.languages.javascript.error;
  import uim.languages.javascript.exceptions;
  import uim.languages.javascript.functions;
  import uim.languages.javascript.helpers;
  import uim.languages.javascript.interfaces;
  import uim.languages.javascript.lexers;
  import uim.languages.javascript.parsers;
  import uim.languages.javascript.tests;
  import uim.languages.javascript.tools;
}

// JavaScript code generation functions
auto jsEvent(string target, string event, string listener) {
  return "%s.addEventListener(%s, %s);".format(target, event, listener);
}

auto jsReturn(string result) {
  return "return " ~ result ~ ";";
}

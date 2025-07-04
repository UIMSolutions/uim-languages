/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.javascript.functions.elements;

import uim.languages.javascript;
@safe:

string jsBlock(DJS someContent, DJS[] someContents...) { 
  return jsBlock(someContent~someContents); 
}

string jsBlock(DJS[] someContents) {
  return jsBlock(
    someContents.map!(c => c.toString).array); 
}

string jsBlock(string[] someContents...) { 
  return jsBlock(someContents.dup); 
}

string jsBlock(string[] someContents) { 
  return "{"~someContents.join()~"}"; 
}

version(test_uim_javascript) { unittest {
	assert(jsBlock() == "{}");
	assert(jsBlock("return;") == "{return;}");
  assert(jsBlock("var a=2;") == "{var a=2;}");
  assert(jsBlock(JS.var("a", "2")) == "{var a=2;}");
}}

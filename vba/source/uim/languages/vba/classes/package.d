/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.vba.classes;

import uim.languages.vba;

public {
  import uim.languages.vba.classes.obj;
}

class DVBA {
  this() {
  }

  // #region content
  // This is the content of the VBA code, which can be built up using various methods
  // such as dim, func, ifThen, ifElse, and sub.
  // It is a string that accumulates the generated code.
  protected string _content;
  string content() {
    return _content;
  }

  string content(string value) {
    _content = value;
    return _content;
  }

  string content(string[] value) {
    _content = value.join("");
    return _content;
  }
  // #endregion

  O dim(O)(string name, string content) {
    _content ~= vbaDim(name, parameters, datatype, content);
    return cast(O)this;
  }

  O func(O)(string name, string[] parameters, string datatype, string content) {
    _content ~= vbaFunction(name, parameters, datatype, content);
    return cast(O)this;
  }

  O ifThen(O)(string[] andConditions, string thenContent) {
    _content ~= vbaIfThen(andConditions, thenContent);
    return cast(O)this;
  }

  O ifElse(O)(string[] andConditions, string thenContent, string elseContent) {
    _content ~= vbaIfElse(andConditions, thenContent, elseContent);
    return cast(O)this;
  }

  O sub(O)(string name, string[] parameters, string content) {
    _content ~= vbaSub(name, parameters, content);
    return cast(O)this;
  }
}

auto VBA() {
  return new DVBA;
}

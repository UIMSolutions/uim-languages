module uim.vba.classes;

import uim.vba;

class DVBA {
  this() {}
  
  mixin(OProperty!("string", "content"));

  O dim(O)(string name, string content) { _content ~= vbaDim(name, parameters, datatype, content); return cast(O)this; }
  O func(O)(string name, string[] parameters, string datatype, string content) { _content ~= vbaFunction(name, parameters, datatype, content); return cast(O)this; }
  O ifThen(O)(string[] andConditions, string thenContent) { _content ~= vbaIfThen(andConditions, thenContent); return cast(O)this; }
  O ifElse(O)(string[] andConditions, string thenContent, string elseContent) { _content ~= vbaIfElse(andConditions, thenContent, elseContent); return cast(O)this; }
  O sub(O)(string name, string[] parameters, string content) { _content ~= vbaSub(name, parameters, content); return cast(O)this; }
}
auto VBA() { return new DVBA; }

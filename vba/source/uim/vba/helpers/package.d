module uim.vba.helpers;

import uim.vba;

string vbaDim(string name, string datatype, string defaultValue = "") {
  return 
`Dim %s as %s
%s  
`.format(name, datatype, (defaultValue.length > 0 ? "name = "~defaultValue~"\n" : ""));
}
unittest {
  // writeln(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`));
/*  assert(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`) == 
  `Function test(a as Integer,b as String) as Integer
a = a + 1
End Function
`); */
}

string vbaDim(string name, string datatype, string defaultValue = "") {
  return 
`Dim %s as %s
%s  
`.format(name, datatype, (defaultValue.length > 0 ? name~" = "~defaultValue~"\n" : ""));
}
unittest {
  // writeln(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`));
/*   assert(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`) == 
  `Function test(a as Integer,b as String) as Integer
a = a + 1
End Function
 `); */
}

string vbaDimObj(string name, string datatype, string defaultValue = "") {
  return 
`Dim %s as %s
%s  
`.format(name, datatype, (defaultValue.length > 0 ? "Set "~name~" = "~defaultValue~"\n" : ""));
}
unittest {
  // writeln(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`));
/*  assert(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`) == 
  `Function test(a as Integer,b as String) as Integer
a = a + 1
End Function
`); */
}

string vbaFunction(string name, string[] parameters, string datatype, string content) {
  return 
`Function %s(%s) as %s
%s  
End Function
`.format(name, parameters.join(","), datatype, content);
}
unittest {
  // writeln(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`));
/*  assert(vbaFunction("test", ["a as Integer", "b as String"], "Integer", `a = a + 1`) == 
  `Function test(a as Integer,b as String) as Integer
a = a + 1
End Function
`); */
}

string vbaSet(string name, string value) {
  return 
  `Set %s = %s
`.format(name, value);
}
unittest {
}

string vbaSub(string name, string[] parameters, string content) {
  string result = `Sub %s(%s)
%s
End Sub`.format(name, parameters.join(","), content) ;

  return result;
}
unittest {
  // writeln(vbaSub("test", ["a as Integer", "b as String"], `a = a + 1`));
/*  assert(vbaSub("test", ["a as Integer", "b as String"], `a = a + 1`) == 
  `Sub test(a as Integer,b as String)
a = a + 1
End Sub`);*/
}

string vbaIfThen(string[] andConditions, string ifContent) {
  string result = `If %s Then
%s
End If`.format(andConditions.join(" AND "), ifContent) ;

  return result;
}
unittest {
}

string vbaIfElse(string[] andConditions, string ifContent, string elseContent) {
  string result = `If %s Then
%s
Else
%s
End If`.format(andConditions.join(" AND "), ifContent, elseContent) ;

  return result;
}
unittest {
}

string vbaSelect(string value, string[string] cases, string defaultCase = "") {
  string[] allCases;
  foreach(key; cases.keys.sort) {
    allCases ~= "case %s\n%s".format(cases);
  }
  if (defaultCase) allCases ~= "default case\n%s".format(defaultCase);
  return `
Select %s
%s
End Select`.format(value, allCases.join("\n"));
}
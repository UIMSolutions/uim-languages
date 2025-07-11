/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.javascript.tools.convert;

import uim.languages.javascript;

@safe:

@safe pure string toJS(T)(T[] values, bool sortedValues = false) {
	string[] result; 

	foreach(value; values.sort) {
		result ~= `%s`.format(value);
	}
	return "["~result.join(",")~"]";
}
version(test_uim_javascript) { unittest {
	assert(["a", "b"].toJS == "[a,b]");
}}

/* @safe */ /* pure */ string toJS(T)(T[string] values, bool sortedKeys = false) {
	string[] result; 
	string[] keys = values.keys(sortedKeys);

	foreach(k; keys) {
		auto key = k;
		if (k.indexOf("-") >= 0) key = "'%s'".format(k);
		result ~= "%s:%s".format(k, values[k]);
	}
	return "{"~result.join(",")~"}";
}
version(test_uim_javascript) { unittest {
	assert(["a":1, "b":2].toJS(SORTED) == "{a:1,b:2}");
}}

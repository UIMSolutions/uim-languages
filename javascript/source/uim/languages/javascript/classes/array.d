﻿/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.languages.javascript.classes.array;

import uim.languages.javascript;

@safe:

class DJSArray(T:string) : DJSRoot {
	this() { super(); }
	this(T[] newItems) { this(); _items = newItems; }

@safe:
	mixin(TProperty!("T[]", "items"));

	size_t length() { return items.length; }
	bool empty() { return (items.length == 0); }
	auto first() { if (!empty) return items[0]; return null; }
	void clear() { _items = null; }

	override string toString() {
		string[] inner;
		foreach(item; items) inner~=to!string(item);

		return "["~inner.join(",")~"]";
	}
}
auto JSArray() { return new DJSArray!string(); }
auto JSArray(T)(T[] newItems) { return new DJSArray!T(newItems); }

auto jsArray(T)(T[] values = null) { 
	if (values) { 
		string[] sets;

	}
	return "[]";
}

version(test_uim_javascript) { unittest {
	// TODO
}}
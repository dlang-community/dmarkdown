/**
	Utility functions for string processing
	Copyright: © 2012-2014 RejectedSoftware e.K.
	License: Subject to the terms of the MIT license, as written in the included LICENSE.txt file.
	Authors: Sönke Ludwig
*/
module dmarkdown.string;

public import std.string;

import std.algorithm;
import std.array;
import std.ascii;
import std.format;
import std.uni;
import std.utf;
import core.exception;


package:

/**
	Checks if all characters in 'str' are contained in 'chars'.
 */
bool allOf(string str, string chars)
@safe pure {
	foreach (dchar ch; str)
		if (!chars.canFind(ch))
			return false;
	return true;
}

ptrdiff_t indexOfCT(Char)(in Char[] s, dchar c, CaseSensitive cs = CaseSensitive.yes)
@safe pure {
	if (__ctfe) {
		if (cs == CaseSensitive.yes) {
			foreach (i, dchar ch; s)
				if (ch == c)
					return i;
		} else {
			c = std.uni.toLower(c);
			foreach (i, dchar ch; s)
				if (std.uni.toLower(ch) == c)
					return i;
		}
		return -1;
	} else return std.string.indexOf(s, c, cs);
}

/**
  Checks if any character in 'str' is contained in 'chars'.
 */
bool anyOf(string str, string chars)
@safe pure {
	foreach (ch; str)
		if (chars.canFind(ch))
			return true;
	return false;
}

/**
	Finds the closing bracket (works with any of '[', '$(LPAREN)', '<', '{').

	Params:
		str = input string
		nested = whether to skip nested brackets
	Returns:
		The index of the closing bracket or -1 for unbalanced strings
		and strings that don't start with a bracket.
*/
sizediff_t matchBracket(string str, bool nested = true)
@safe pure nothrow {
	if (str.length < 2) return -1;
	
	char open = str[0], close = void;
	switch (str[0]) {
		case '[': close = ']'; break;
		case '(': close = ')'; break;
		case '<': close = '>'; break;
		case '{': close = '}'; break;
		default: return -1;
	}
	
	size_t level = 1;
	foreach (i, char c; str[1 .. $]) {
		if (nested && c == open) ++level;
		else if (c == close) --level;
		if (level == 0) return i + 1;
	}
	return -1;
}

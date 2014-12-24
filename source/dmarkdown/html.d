/**
	HTML character entity escaping.

	TODO: Make things @safe once Appender is.

	Copyright: © 2012-2014 RejectedSoftware e.K.
	License: Subject to the terms of the MIT license, as written in the included LICENSE.txt file.
	Authors: Sönke Ludwig
*/
module dmarkdown.html;

import std.array;
import std.conv;
import std.range;


package:


/** Writes the HTML escaped version of a given string to an output range.
*/
void filterHTMLEscape(R, S)(ref R dst, S str, HTMLEscapeFlags flags = HTMLEscapeFlags.escapeNewline)
	if (isOutputRange!(R, dchar) && isInputRange!S)
{
	for (;!str.empty;str.popFront())
		filterHTMLEscape(dst, str.front, flags);
}

/** Writes the HTML escaped version of a given string to an output range (also escapes double quotes).
*/
void filterHTMLAttribEscape(R, S)(ref R dst, S str)
	if (isOutputRange!(R, dchar) && isInputRange!S)
{
	for (; !str.empty; str.popFront())
		filterHTMLEscape(dst, str.front, HTMLEscapeFlags.escapeNewline|HTMLEscapeFlags.escapeQuotes);
}

/** Writes the HTML escaped version of a given string to an output range (escapes every character).
*/
void filterHTMLAllEscape(R, S)(ref R dst, S str)
	if (isOutputRange!(R, dchar) && isInputRange!S)
{
	for (; !str.empty; str.popFront()) {
		dst.put("&#");
		dst.put(to!string(cast(uint)str.front));
		dst.put(';');
	}
}

/**
	Writes the HTML escaped version of a character to an output range.
*/
void filterHTMLEscape(R)(ref R dst, dchar ch, HTMLEscapeFlags flags = HTMLEscapeFlags.escapeNewline )
{
	switch (ch) {
		default:
			if (flags & HTMLEscapeFlags.escapeUnknown) {
				dst.put("&#");
				dst.put(to!string(cast(uint)ch));
				dst.put(';');
			} else dst.put(ch);
			break;
		case '"':
			if (flags & HTMLEscapeFlags.escapeQuotes) dst.put("&quot;");
			else dst.put('"');
			break;
		case '\'':
			if (flags & HTMLEscapeFlags.escapeQuotes) dst.put("&#39;");
			else dst.put('\'');
			break;
		case '\r', '\n':
			if (flags & HTMLEscapeFlags.escapeNewline) {
				dst.put("&#");
				dst.put(to!string(cast(uint)ch));
				dst.put(';');
			} else dst.put(ch);
			break;
		case 'a': .. case 'z': goto case;
		case 'A': .. case 'Z': goto case;
		case '0': .. case '9': goto case;
		case ' ', '\t', '-', '_', '.', ':', ',', ';',
		     '#', '+', '*', '?', '=', '(', ')', '/', '!',
		     '%' , '{', '}', '[', ']', '`', '´', '$', '^', '~':
		    dst.put(cast(char)ch);
			break;
		case '<': dst.put("&lt;"); break;
		case '>': dst.put("&gt;"); break;
		case '&': dst.put("&amp;"); break;
	}
}


enum HTMLEscapeFlags {
	escapeMinimal = 0,
	escapeQuotes = 1<<0,
	escapeNewline = 1<<1,
	escapeUnknown = 1<<2
}

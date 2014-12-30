=========
DMarkdown
=========


.. image:: https://api.travis-ci.org/kiith-sa/dmarkdown.svg
.. image:: https://raw.githubusercontent.com/kiith-sa/dmarkdown/master/code.dlang.org-shield.png
   :target: http://code.dlang.org


------------
Introduction
------------

DMarkdown is an open source `Markdown <http://en.wikipedia.org/wiki/Markdown>`_ to HTML
processor for the `D programming language <http://dlang.org>`_. It provides a simple,
minimal API to generate HTML from markdown strings or ranges.

DMarkdown code was originally written as a part of the `vibe.d <http://vibed.org/>`_
project and its API (and most of its implementation) is identical to the
``vibe.textfilter.markdown`` module from vibe.d .


---------------
Getting Started
---------------

Assuming you use `dub <http://code.dlang.org/about>`_, add this line::

   "dmarkdown": { "version" : "~>0.1.0" }

to the ``"dependencies"`` in your project's ``dub.json``/``package.json``.

* Basic example:

  .. code-block:: d

     import dmarkdown;

     string text = 
         "=======\n"
         "Heading\n"
         "=======\n"
         "\n"
         "**bold** *italic*\n"
         "\n"
         "List:\n"
         "\n"
         "  * a\n"
         "  * b\n"
         "  * c\n";
     string html = filterMarkdown(text);
     import std.stdio;
     writeln(html);


To see API details, see the `dmarkdown.markdown
<https://github.com/kiith-sa/dmarkdown/blob/master/source/dmarkdown/markdown.d>`_ module.

.. Add this section when there's something to talk about
.. --------
.. Features
.. --------

.. * Can write into both strings and character ranges.
.. * No dependencies other than the standard library.


-------------------
Directory structure
-------------------

===============  =======================================================================
Directory        Contents
===============  =======================================================================
``./``           This README, auxiliary files.
``./source``     Source code.
===============  =======================================================================


-------
License
-------

DMarkdown is released under the terms of the `MIT
<http://en.wikipedia.org/wiki/MIT_License>`_ license.  This license allows you to use the
source code in your own projects, open source or proprietary, and to modify it to suit
your needs.

Full text of the license can be found in file ``LICENSE.txt`` and is also displayed here::

   Copyright (c) 2012-2014 RejectedSoftware e.K.

   Permission is hereby granted, free of charge, to any person obtaining a copy of this
   software and associated documentation files (the "Software"), to deal in the Software
   without restriction, including without limitation the rights to use, copy, modify,
   merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to the following
   conditions:

   The above copyright notice and this permission notice shall be included in all copies
   or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
   INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR
   A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
   CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
   THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-------
Credits
-------

DMarkdown code was written as a part of the `vibe.d <http://vibed.org/>`_ project by
rejectedsoftware e.K. . Modifications by Ferdinand Majerech.

See more `D <http://www.dlang.org>`_ libraries and projects at `code.dlang.org
<http://code.dlang.org>`_.

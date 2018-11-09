# Qgoda-TT2-Plugin-Highlight

This plug-in provides syntax highlighting for [Qgoda](http://www.qgoda.net/).

## SYNOPSIS

```tt2
[% USE Highlight %]
...
[% Filter $Highlight "language-javascript" "line-numbers" "data-start"=5 %]
use "strict";

console.log("Hello, world!\n");
[% END %]
```

You can also use this plug-in without Qgoda.

## DESCRIPTION

This [Qgoda](http://www.qgoda.net/) plug-in for the
[Template Toolkit](http://www.template-toolkit.org/) allows you to create 
code blocks that can be syntax-highlighted in the browser.  It works perfectly
with [PrismJS](https://prismjs.com/) but other libraries that follow the
recommendation for code blocks in HTML are equally supported.

The filter wraps its content into an HTML "code" element that in turn is wrapped into
an HTML "pre".  The above example from the synopsis would result in the following
HTML:

```html
<pre class="language-javascript line-numbers" data-start="5"><code>use "strict";

console.log("Hello, world!\n");</code></pre>
```

All positional arguments (those without an equals sign) to the filter are accumulated
in the class attribute of the "pre" element. All named arguments (those with an equals
sign) are converted into other attributes.

Leading and trailing whitespace around the source snippet is stripped off and
discarded.

*Important!* If you are using
[Text::Markup::Hoedown](https://metacpan.org/release/Text-Markdown-Hoedown)as your markdown processor, you can alternatively use fenced codeblocks:

<pre class="language-markdown"><code>```javascript
use "strict";

console.log("Hello, world!\n");
```</code></pre>

This will result in the same HTML code but only with a class attribute of
"language-javascript". If you need additional classes or attributes, you have to
use this filter.

*Important!* It is your responsability to add all the required JavaScript and
CSS to the page that is needed for syntax highlighting.  See
https://prismjs.com/ for an example, how to include the required assets.

## Installation and Update

Like all Qgoda plug-ins, there is no need to install
from CPAN (although you can).

### With Node.JS Package Manager

Check that your Qgoda project directory contains a file `package.json`.  If
not, create one with either `npm init` or `yarn init`.

#### NPM

With NPM, you install the plug-in and update it to the latest version like
this:

```bash
$ npm install --save-dev gflohr/qgoda-plugin-tt2-highlight
$ npm update gflohr/qgoda-plugin-tt2-hightlight
```

#### YARN

With Yarn, you install the plug-in and update it to the latest version like
this:

```bash
$ yarn add gflohr/qgoda-plugin-tt2-highlight
$ npm upgrade gflohr/qgoda-plugin-tt2-hightlight
```

Either way, it will be recognized as a plug-in, the next time you start
[Qgoda](http://www.qgoda.net/).

### From Version Control

You can also install the plug-in directly from git.

```bash
$ cd /path/to/your/qgoda/project
$ test -e _plugins || mkdir _plugins
$ git clone https://github.com/gflohr/qgoda-plugin-tt2-highlight
```

This will download the latest version into the directory `_plugins` where
it will be recognized as a plug-in, the next time you start
[Qgoda](http://www.qgoda.net/).

### From CPAN

You can also install from CPAN, if you can't help.  One of the following two options should work:

#### cpanm

```bash
$ sudp cpanm Qgoda::Plugin::TT2::Highlight
```

The command `cpanm` comes with [App-cpanminus](https://metacpan.org/release/App-cpanminus).

#### cpan

```bash
$ sudo cpan install Qgoda::Plugin::TT2::Highlight
```

## Copyright

Copyright (C) 2018 Guido Flohr guido.flohr@cantanea.com, all rights
reserved.

This library is free software. It comes without any warranty, to the
extent permitted by applicable law. You can redistribute it and/or
modify it under the terms of the Do What the Fuck You Want to Public
License, Version 2, as published by Sam Hocevar. See
http://www.wtfpl.net/ for more details.

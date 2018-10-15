#! /bin/false
# Copyright (C) 2018 Guido Flohr <guido.flohr@cantanea.com>
#               All rights reserved
#
# This library is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What the Fuck You Want
# to Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

package Qgoda::TT2::Plugin::Highlight;

use strict;

use base qw(Template::Plugin::Filter);

use Qgoda::Util qw(trim html_escape);

sub init {
    my ($self) = @_;

    $self->{_DYNAMIC} = 1;

    return $self;
}

sub filter {
    my ($self, $src, $args, $conf) = @_;

    $src = trim $src;
    next if !length $src;

    my $html = "<pre";
    if ($args && @$args) {
        my $class = join ' ', map { html_escape $_ } @$args;
        $html .= qq{ class="$class"};
    }
    foreach my $attr (sort keys %{$conf || {}}) {
        my $value = html_escape $conf->{$attr};
        $html .= qq{ $attr="$value"};
    }

    $html .= "><code>$src</pre></code>";

    return $html;
}

1;

=head1  NAME

Qgoda::TT2::Plugin::Highlight - Syntax highlighting

=head1 SYNOPSIS

    [% USE Highlight %]
    ...
    [% Filter $Highlight "language-javascript" "line-numbers" "data-start"=5 %]
    use "strict";

    console.log("Hello, world!\n");
    [% END %]

=head1 DESCRIPTION

This L<Qgoda|http://www.qgoda.net/> plug-in for the 
L<Template Toolkit|http://www.template-toolkit.org/> allows you to create code blocks
that can be syntax-highlighted in the browser.  It works perfectly with
L<PrismJS|https://prismjs.com/> but other libraries that follow the recommendation for
code blocks in HTML are equally supported.

The filter wraps its content into an HTML "code" element that in turn is wrapped into
an HTML "pre".  The above example from the synopsis would result in the following
HTML:

    <pre class="language-javascript line-numbers" data-start="5"><code>use "strict";

    console.log("Hello, world!\n");</code></pre>

All positional arguments (those without an equals sign) to the filter are accumulated
in the class attribute of the "pre" element. All named arguments (those with an equals
sign) are converted into other attributes.

Leading and trailing whitespace around the source snippet is discaded.

B<Important!> If you are using L<Text::Markup::Hoedown> as your markdown processor,
you can alternatively use fenced codeblocks:

    ```javascript
    use "strict";

    console.log("Hello, world!\n");
    ```

This will result in the same HTML code but only with a class attribute of
"language-javascript". If you need additional classes or attributes, you have to
use this filter.

B<Important!> It is your responsability to add all the required JavaScript and
CSS to the page that is needed for syntax highlighting.  See 
L<https://prismjs.com/> for an example, how to include the required assets.

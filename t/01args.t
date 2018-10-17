#! /usr/bin/env perl

# Copyright (C) 2018 Guido Flohr <guido.flohr@cantanea.com>
#               All rights reserved
#
# This library is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What the Fuck You Want
# to Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

use strict;

use Test::More;
use Template 2.27;

use Qgoda::Processor::TT2;

my $processor = Qgoda::Processor::TT2->new;
my $template = <<'EOF';
[%- USE Highlight -%]
[%- FILTER $Highlight "language-perl" "line-numbers" "data-start"=5 %]
print "Hello, world!\n";
[% END %]
EOF
my $got = $processor->process($template, {}, 'in-memory');

my $expected = <<'EOF';
<pre class="language-perl line-numbers" data-start="5"><code>print "Hello, world!\n";</code></pre>
EOF
is $got, $expected;

$template = <<'EOF';
[%- USE Highlight "class1" "class2" more="there" -%]
[%- FILTER $Highlight "language-perl" other="foo" %]
print "Hello, world!\n";
[% END %]
EOF
$got = $processor->process($template, {}, 'in-memory');
$expected = <<'EOF';
<pre class="class1 class2 language-perl" more="there" other="foo"><code>print "Hello, world!\n";</code></pre>
EOF
is $got, $expected;

$template = <<'EOF';
[%- USE Highlight "class1" "class2" more="there" -%]
[%- FILTER $Highlight "language-perl" "-class2" more="here" %]
print "Hello, world!\n";
[% END %]
EOF
$got = $processor->process($template, {}, 'in-memory');
$expected = <<'EOF';
<pre class="class1 language-perl" more="here"><code>print "Hello, world!\n";</code></pre>
EOF
is $got, $expected;

done_testing;

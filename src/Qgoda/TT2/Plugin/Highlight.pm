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

Qgoda::TT2::Plugin::Highlight - Syntax highlighting for Qgoda

=head1 DESCRIPTION

See L<https://github.com/gflohr/qgoda-plugin-tt2-highlight>!

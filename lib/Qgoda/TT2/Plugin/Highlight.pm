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

use Qgoda '0.9.2';

use Qgoda::Util qw(trim html_escape tt2_args_merge);

sub new {
    my ($class, $ctx, @args) = @_;

    my $conf = {};
    if (@args && ref $args[-1] && 'HASH' eq ref $args[-1]) {
        $conf = pop @args;
    }
    my $self = $class->SUPER::new($ctx);

    $self->{__args} = \@args;
    $self->{__conf} = $conf;

    return $self;
}

sub init {
    my ($self) = @_;

    $self->{_DYNAMIC} = 1;

    return $self;
}

sub filter {
    my ($self, $src, $local_args, $local_conf) = @_;

    $src = trim $src;
    next if !length $src;
    
    $src = html_escape $src;
    
    my ($args, $conf) = tt2_args_merge $self->{__args}, $self->{__conf},
                                       $local_args, $local_conf;
    my $html = "<pre";
    if ($args && @$args) {
        my $class = join ' ', map { html_escape $_ } @$args;
        $html .= qq{ class="$class"};
    }
    foreach my $attr (sort keys %{$conf || {}}) {
        my $value = html_escape $conf->{$attr};
        $html .= qq{ $attr="$value"};
    }

    $html .= "><code>$src</code></pre>";

    return $html;
}

1;

=head1  NAME

Qgoda::TT2::Plugin::Highlight - Syntax highlighting for Qgoda

=head1 DESCRIPTION

See L<https://github.com/gflohr/qgoda-tt2-plugin-highlight>!

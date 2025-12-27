package App::Docker::Info;

use 5.018;
use strict;
use warnings;
use version;
use Carp qw(carp);

our $VERSION = version->declare("v0.2.0");

use Exporter   qw( );
use List::Util qw( uniq );

our @EXPORT      = ();
our @EXPORT_OK   = ();
our %EXPORT_TAGS = ( all => \@EXPORT_OK );    # Optional.

sub import {
    my $class = shift;
    my (@packages) = @_;

    my ( @pkgs, @rest );
    for (@packages) {
        if (/^::/) {
            push @pkgs, __PACKAGE__ . $_;
        }
        else {
            push @rest, $_;
        }
    }

    for my $pkg (@pkgs) {
        my $mod = ( $pkg =~ s{::}{/}gr ) . ".pm";
        require $mod;

        my $exports = do { no strict "refs"; \@{ $pkg . "::EXPORT_OK" } };
        $pkg->import(@$exports);
        @EXPORT    = uniq @EXPORT,    @$exports;
        @EXPORT_OK = uniq @EXPORT_OK, @$exports;
    }

    @_ = ( $class, @rest );
    goto &Exporter::import;
}

1;    # End of App::Docker::Info

=pod

=encoding utf-8

=head1 NAME

App::Docker::Info - Gathers information about docker images, containers, volumes, and system.

=head1 VERSION

Version v0.2.0

=head1 SYNOPSIS

App::Docker::Info provides a loader for sub-modules where a leading :: denotes a package to load.

    use App::Docker::Info qw( ::OS ::Utils );

This is equivalent to:

    user App::Docker::Info::OS    qw(:all);
    user App::Docker::Info::Utils qw(:all);



=head1 SEE ALSO

L<App::Docker::Info::Image>,
L<App::Docker::Info::Container>,
L<App::Docker::Info::Volume>,
L<App::Docker::Info::System>,


=head1 AUTHOR

Matt Martini, C<< <matt.martini at imaginarywave.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-dev-util at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dev-Util>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 INSTALLATION

To install this module, see F<INSTALL.md>

TLDR; run the following commands:

    perl Makefile.PL
    make
    make test
    make install

=head1 SUPPORT AND DOCUMENTATION

You can find documentation for this module with the perldoc command.

    perldoc Dev::Util

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Dev-Util>

=item * Search CPAN

L<https://metacpan.org/release/Dev-Util>

=back

=head1 HISTORY

This module was originally developed under the name C<MERM::Base>.


=head1 TEMPLATE

    module-starter \
        --module=App::Docker::Info \
        --module=App::Docker::Info::Image \
        --module=App::Docker::Info::Container \
        --module=App::Docker::Info::Volume \
        --module=App::Docker::Info::System \
        --builder=ExtUtils::MakeMaker \
        --author='Matt Martini' \
        --email=matt@imaginarywave.com \
        --ignore=git \
        --license=gpl3 \
        --genlicense \
        --minperl=5.018 \
        --verbose

=head1 ACKNOWLEDGMENTS

=head1 LICENSE AND COPYRIGHT

This software is Copyright © 2024-2025 by Matt Martini.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut

__END__

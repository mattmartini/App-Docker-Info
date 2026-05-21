package App::Docker::Info::Container;

use Dev::Util::Syntax;
use Dev::Util::File   qw(read_list);
use App::Docker::Info qw(::Utils);

use Exporter qw(import);

use IPC::Cmd qw[can_run run];
use Data::Printer;

our $VERSION = version->declare("v0.13.0");

our @EXPORT_OK = qw(
    get_containers
    get_container_ids
    get_active_container_list
    get_all_container_list
    inspect_container
);

our %EXPORT_TAGS = ( all => \@EXPORT_OK );

sub get_container_ids {
    my $args = q{container list -q};

    my $ids_ref = pull_info($args);
    return $ids_ref;
}

sub get_active_container_list {
    my $args = q{container list --format='{{json .}}'};

    my $containers_ref = pull_info($args);
    return $containers_ref;
}

sub get_all_container_list {
    my $args = q{container list -a --format='{{json .}}'};

    my $containers_ref = pull_info($args);
    return $containers_ref;
}

sub inspect_container {
    my $id = shift;

    my $args = q{container inspect --format='{{json .}}' };
    $args .= $id;

    my $containers_ref = pull_info($args);
    return $containers_ref;
}

sub read_container_ids {
    my $file = shift;

    unless ( $file =~ m{\.json$} ) {
        carp "A json file must be provided.\n";
        return;
    }
    return read_info($file);
}

# read each type of get, send thru filter to extract relevant data
1;    # Magic true value required at end of module

=pod

=encoding utf-8

=head1 NAME

App::Docker::Info::Container - Gather and Display info about Docker Containers

=head1 VERSION

Version v0.13.0

=head1 SYNOPSIS

    use App::Docker::Info::Container;

=head1 EXPORT

    get_os

=head1 SUBROUTINES


=head1 AUTHOR

Matt Martini, C<< <matt at imaginarywave.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-dev-util at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-Docker-Info>.  I will
be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::Docker::Info

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Docker-Info>

=item * Search CPAN

L<https://metacpan.org/release/App-Docker-Info>

=back

=head1 ACKNOWLEDGMENTS

=head1 LICENSE AND COPYRIGHT

This software is Copyright © 2025-2026 by Matt Martini.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

=cut

__END__

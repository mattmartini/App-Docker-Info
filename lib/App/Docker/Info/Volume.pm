package App::Docker::Info::Volume;

use Dev::Util::Syntax;
use Dev::Util::File   qw(read_list);
use App::Docker::Info qw(::Utils);

use Exporter qw(import);

use IPC::Cmd qw[can_run run];
use Data::Printer;

our $VERSION = version->declare("v0.13.0");

our @EXPORT_OK = qw(
    get_volumes
    get_volume_ids
    get_active_volume_list
    get_all_volume_list
    inspect_volume
);

our %EXPORT_TAGS = ( all => \@EXPORT_OK );

sub get_volume_ids {
    my $args = q{volume list -q};

    my $ids_ref = pull_info($args);
    return $ids_ref;
}

sub get_active_volume_list {
    my $args = q{volume list --format='{{json .}}'};

    my $volumes_ref = pull_info($args);
    return $volumes_ref;
}

sub get_all_volume_list {
    my $args = q{volume list -a --format='{{json .}}'};

    my $volumes_ref = pull_info($args);
    return $volumes_ref;
}

sub inspect_volume {
    my $id = shift;

    my $args = q{volume inspect --format='{{json .}}' };
    $args .= $id;

    my $volumes_ref = pull_info($args);
    return $volumes_ref;
}

sub read_volume_ids {
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

App::Docker::Info::Volume - Gather and Display info about Docker Volumes

=head1 VERSION

Version v0.13.0

=head1 SYNOPSIS

    use App::Docker::Info::Volume;

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

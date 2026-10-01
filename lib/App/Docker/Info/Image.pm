package App::Docker::Info::Image;

use Dev::Util::Syntax;
use Dev::Util::File   qw(read_list);
use App::Docker::Info qw(::Utils);

use Exporter qw(import);

use IPC::Cmd qw[can_run run];
use Data::Printer;

our $VERSION = version->declare("v0.21.0");

our @EXPORT_OK = qw(
    get_image_ids
    get_image_list
    inspect_image
    display_image_ids
);

our %EXPORT_TAGS = ( all => \@EXPORT_OK );

sub get_image_ids {
    my $args = q{image list -q};

    my $ids_ref = pull_info($args);
    return $ids_ref;
}

sub get_image_list {
    my $all = shift || 0;
    my $args;

    if ( $all == 1 ) {
        $args = q{image list -a --format='{{json .}}'};
    }
    else {
        $args = q{image list --format='{{json .}}'};
    }

    my $images_ref = pull_info($args);
    return $images_ref;
}

sub inspect_image {
    my $id = shift;

    my $args = q{image inspect --format='{{json .}}' };
    $args .= $id;

    my $images_ref = pull_info($args);
    return $images_ref;
}

sub read_image_ids {
    my $file = shift;

    unless ( $file =~ m{\.json$} ) {
        carp "A json file must be provided.\n";
        return;
    }
    return read_info($file);
}

sub display_image_ids {
    my $ids_ref = get_image_ids();
    printf "%s\n", $_ for $ids_ref->@*;
    return;
}

# read each type of get, send thru filter to extract relevant data

1;

=pod

=encoding utf-8

=head1 NAME

App::Docker::Info::Image - Gather and Display info about Docker Images

=head1 VERSION

Version v0.21.0

=head1 SYNOPSIS

App::Docker::Info::Image - Get info on docker images including list of ids, active images,
all images, and inspect an image.

    use App::Docker::Info::Image qw(:all);

    my $ids_ref             = get_image_ids();
    my $image_list_ref      = get_image_list($all);
    my $image_inspect_ref   = inspect_image($id);

=head1 EXPORT

    get_image_ids
    get_image_list
    inspect_image
    read_image_ids
    display_image_ids

=head1 SUBROUTINES

=head2 B<get_image_ids>

Return a list of the docker image ids

    my $ids_ref = get_image_ids();

=head2 B<get_image_list(ALL)>

Return a list of json data for each active docker image

C<ALL> get all images (1) or active only images (0, default)

    my $image_list_ref = get_image_list($all);

=head2 B<inspect_image(ID)>

Return json data for an inspection of the id  

C<ID> docker image id to inspect

    my $image_inspect_ref = inspect_image($id);

=head1 AUTHOR

Matt Martini, C<< <matt at imaginarywave.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-docker-info at rt.cpan.org>, or through
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

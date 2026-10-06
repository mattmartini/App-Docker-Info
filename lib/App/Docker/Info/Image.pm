package App::Docker::Info::Image;

use Dev::Util::Syntax;
use Dev::Util::File   qw(read_list);
use App::Docker::Info qw(::Utils);

use Exporter qw(import);

use IPC::Cmd        qw[can_run run];
use Term::ANSIColor qw(color colored :constants256 RESET);
use Data::Printer;

our $VERSION = version->declare("v0.21.0");

our @EXPORT_OK = qw(
    get_image_ids
    get_image_list
    inspect_image
    display_image_ids
    display_image_list
    display_image_inspect
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
        $args = q{image list -a --no-trunc --format='{{json .}} '};
    }
    else {
        $args = q{image list --no-trunc --format='{{json .}} '};
    }

    my $images_ref = pull_info($args);
    return $images_ref;
}

sub inspect_image {
    my $id = shift;

    my $args = q{image inspect };
    $args .= $id;
    $args .= q{ --format='{{json .}}'};

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

sub display_image_list {
    my $all = shift || 0;

    my $images_ref       = get_image_list($all);
    my $images_array_ref = aoj_to_aoh($images_ref);

    foreach my $image_ref ( $images_array_ref->@* ) {

        my @matches = $image_ref->{ Repository } =~ m{([^/]+)/?}g;
        if ( scalar @matches == 1 ) {
            $image_ref->{ Registry } = 'docker.io';
            $image_ref->{ Owner }    = 'library';
            $image_ref->{ Image }    = $matches[0];
        }
        elsif ( scalar @matches == 2 ) {
            $image_ref->{ Registry } = 'docker.io';
            $image_ref->{ Owner }    = $matches[0];
            $image_ref->{ Image }    = $matches[1];
        }
        elsif ( scalar @matches == 3 ) {
            $image_ref->{ Registry } = $matches[0];
            $image_ref->{ Owner }    = $matches[1];
            $image_ref->{ Image }    = $matches[2];
        }
        else {
            carp "Bad registry\n";
        }
    }

    my ( $prevRegistry, $prevOwner, $prevImage, $prevTag )
        = ( q{}, q{}, q{}, q{} );
    foreach my $image_ref (
                            sort {
                                   $a->{ Registry } cmp $b->{ Registry }
                                || $a->{ Owner }    cmp $b->{ Owner }
                                || $a->{ Image }    cmp $b->{ Image }
                                || $a->{ Tag }      cmp $b->{ Tag }
                            } $images_array_ref->@*
                          )
    {
        my @values;
        $values[0]
            = { val   => $image_ref->{ Registry },
                cond  => $image_ref->{ Registry } ne $prevRegistry,
                color => 'green',
                fmt   => "%s\n"
              };

        $values[1]
            = { val   => $image_ref->{ Owner },
                cond  => $image_ref->{ Owner } ne $prevOwner,
                color => 'yellow',
                fmt   => "  %s\n"
              };

        $values[2]
            = { val  => $image_ref->{ Image } . ':' . $image_ref->{ Tag },
                cond => $image_ref->{ Image } ne $prevImage
                || $image_ref->{ Tag } ne $prevTag,
                color => $image_ref->{ Containers } > 0 ? 'blue' : 'ANSI247',
                fmt   => "    %s\n"
              };

        my $shortID
            = $image_ref->{ ID } =~ s{^sha256:([[:xdigit:]]{12})[[:xdigit:]]+}{$1}r;
        $values[3]
            = { val => $shortID,
                fmt => "      %12s"
              };
        $values[4]
            = { val => $image_ref->{ CreatedSince },
                fmt => "%18s"
              };
        $values[5]
            = { val => $image_ref->{ Size },
                fmt => "%10s  "
              };
        $values[6]
            = { val   => $image_ref->{ Containers },
                cond  => $image_ref->{ Containers } > 0,
                color => 'bright_black on_green',
                fmt   => "%s"
              };

        display_params( \@values );
        print "\n";

        $prevRegistry = $image_ref->{ Registry };
        $prevOwner    = $image_ref->{ Owner };
        $prevImage    = $image_ref->{ Image };
        $prevTag      = $image_ref->{ Tag };

    }

    return;
}

sub display_image_inspect {
    my $id              = shift;
    my $image_array_ref = inspect_image($id);
    my $inspect_ref     = aoj_to_aoh($image_array_ref);

    # p $inspect_ref;
    say q{};
    foreach my $image_ref ( $inspect_ref->@* ) {
        my @values;

        my $repository = $image_ref->{ Identity }->{ Pull }->[0]->{ Repository };
        if ( !defined $repository ) {
            $repository = $image_ref->{ RepoTags }->[0];
        }
        my @matches = $repository =~ m{([^/]+)/?}g;
        if ( scalar @matches == 1 ) {
            $image_ref->{ Registry } = 'docker.io';
            $image_ref->{ Owner }    = 'library';
            $image_ref->{ Image }    = $matches[0];
        }
        elsif ( scalar @matches == 2 ) {
            $image_ref->{ Registry } = 'docker.io';
            $image_ref->{ Owner }    = $matches[0];
            $image_ref->{ Image }    = $matches[1];
        }
        elsif ( scalar @matches == 3 ) {
            $image_ref->{ Registry } = $matches[0];
            $image_ref->{ Owner }    = $matches[1];
            $image_ref->{ Image }    = $matches[2];
        }
        else {
            carp "Bad registry\n";
        }

        my $shortID
            = $image_ref->{ Id } =~ s{^sha256:([[:xdigit:]]{12})[[:xdigit:]]+}{$1}r;
        push @values,
            {  val   => $shortID,
               color => 'cyan',
               fmt   => "%s"
            };

        push @values,
            {  val =>
               $image_ref->{ Config }->{ Labels }->{ 'org.opencontainers.image.title' },
               cond =>
               defined $image_ref->{ Config }->{ Labels }
               ->{ 'org.opencontainers.image.title' },
               color => 'cyan',
               fmt   => "  -  %s"
            };

        push @values,
            {  val =>
               $image_ref->{ Config }->{ Labels }->{ 'org.opencontainers.image.version' },
               cond =>
               defined $image_ref->{ Config }->{ Labels }
               ->{ 'org.opencontainers.image.version' },
               color => 'cyan',
               fmt   => "   %s"
            };

        push @values,
            {  val =>
               $image_ref->{ Config }->{ Labels }->{ 'org.opencontainers.image.version' },
               cond  => defined $image_ref->{ Config }->{ Labels }->{ service },
               color => 'cyan',
               fmt   => "  - %s\n"
            };

        push @values,
            {  val  => q{ },
               cond => !defined $image_ref->{ Config }->{ Labels }->{ service },
               fmt  => "%s\n"
            };

        push @values,
            {  val   => $image_ref->{ Registry },
               color => 'green',
               fmt   => "  %s/"
            };

        push @values,
            {  val   => $image_ref->{ Owner },
               color => 'yellow',
               fmt   => "%s/"
            };

        push @values,
            ## = { val   => $image_ref->{ Image } . ':' . $image_ref->{ Tag },
            {  val   => $image_ref->{ Image },
               color => scalar $image_ref->{ RepoTags } > 0 ? 'blue' : 'ANSI247',
               fmt   => "%s"
            };

        push @values,
            {  val  => $image_ref->{ Author },
               cond => defined $image_ref->{ Author },
               fmt  => "  -  %s\n"
            };

        push @values,
            {  val  => q{ },
               cond => !defined $image_ref->{ Author },
               fmt  => "%s\n"
            };

        my $repotags = join "\n    ", $image_ref->{ RepoTags }->@*;
        push @values,
            {  val => $repotags,
               fmt => "    %s\n"
            };

        push @values,
            {  val  => $image_ref->{ Architecture },
               cond => defined $image_ref->{ Architecture },
               fmt  => "  %s"
            };

        push @values,
            {  val  => $image_ref->{ Os },
               cond => defined $image_ref->{ Os },
               fmt  => "  %s"
            };

        my $sizeM = $image_ref->{ Size } / 1e6;
        push @values,
            {  val  => $sizeM,
               cond => defined $image_ref->{ Size },
               fmt  => "  %sM"
            };

        push @values,
            {  val  => $image_ref->{ Created },
               cond => defined $image_ref->{ Created },
               fmt  => "  %s\n"
            };

        my $exposed_ports = join "\n    ",
            keys $image_ref->{ Config }->{ ExposedPorts }->%*;
        push @values,
            {  val  => $exposed_ports,
               cond => $exposed_ports ne q{},
               fmt  => "  %s\n"
            };

        display_params( \@values );
    }

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
    display_image_list
    display_image_inspect

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

=head2 B<display_image_ids>

Display a list of the image ids

    display_image_ids;

=head2 B<display_image_list>

Display info for each image

    display_image_list;

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

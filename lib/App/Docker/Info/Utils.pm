package App::Docker::Info::Utils;

use Dev::Util::Syntax;
use Dev::Util       qw(::Const ::OS);
use Dev::Util::File qw(read_list);

use Exporter qw(import);
use IPC::Cmd qw(can_run run);
use JSON::MaybeXS;

our $VERSION = version->declare("v0.21.0");

our @EXPORT_OK = qw(
    get_docker_cmd
    pull_info
    read_info
    sort_array_ref
    json_to_hash_ref
);

our %EXPORT_TAGS = ( all => \@EXPORT_OK );

sub get_docker_cmd {
    my $cmd_path = can_run('docker')
        or croak "docker command not found.\n";

    return $cmd_path;
}

sub pull_info {
    my $args = shift;

    my $cmd = get_docker_cmd();

    my @lines = ipc_run_c(
                           { cmd     => $cmd . $SPACE . $args,
                             verbose => 0,
                             timeout => 5
                           }
                         );

    return \@lines;
}

sub read_info {
    my $file = shift or die "A json file is required \n";

    my @lines = read_list($file);

    return \@lines;
}

sub sort_array_ref {
    my $array_ref = shift;
    return unless ( ref($array_ref) eq 'ARRAY' );
    my $sorted_array_ref;
    @$sorted_array_ref = sort { $a cmp $b } @$array_ref;
    return $sorted_array_ref;
}

sub json_to_hash_ref {
    my $json     = shift;
    my $json_obj = JSON->new->utf8->allow_nonref;
    my $hash_ref = $json_obj->decode($json);
    return $hash_ref;
}

1;    # Magic true value required at end of module

=pod

=encoding utf-8

=head1 NAME

App::Docker::Info::Utils - Utilities for gathering and displaying Docker info

=head1 VERSION

Version v0.21.0

=head1 SYNOPSIS

    use App::Docker::Info::Utils qw(:all);

    my $cmd = get_docker_cmd();
    my @image_list = pull_info('image list -q');

=head1 EXPORT

    get_docker_cmd
    pull_info
    sort_array_ref
    json_to_hash_ref

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

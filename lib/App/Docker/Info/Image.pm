package App::Docker::Info::Image;

use Dev::Util::Syntax;
use Dev::Util::File qw(read_list);
use Exporter        qw(import);

use IPC::Cmd qw[can_run run];
use Data::Printer;

our $VERSION = version->declare("v0.2.0");

our @EXPORT_OK = qw(
    get_images
    get_image_list
);

our %EXPORT_TAGS = ( all => \@EXPORT_OK );

my $src_dir = '/Users/martini/Development/App-Docker-Info/scratch/';

my $image_dir = $src_dir . 'image/';

my $image_list_file = $image_dir . 'image.list.q.txt';

sub get_image_list {
    my $file = shift or die "A image json file is required \n";

    my @lines = read_list($image_list_file);

    return @lines;
}

1;

=pod

=encoding utf-8

=head1 NAME

App::Docker::Info::Image - [One line description of module's purpose here]

=head1 VERSION

Version v2.19.29

=head1 SYNOPSIS

    use App::Docker::Info::Image;

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

This software is Copyright © 2025 by Matt Martini.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

=cut

__END__

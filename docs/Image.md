# NAME

App::Docker::Info::Image - Gather and Display info about Docker Images

# VERSION

Version v0.21.0

# SYNOPSIS

App::Docker::Info::Image - Get info on docker images including list of ids, active images,
all images, and inspect an image.

    use App::Docker::Info::Image qw(:all);

    my $ids_ref             = get_image_ids();
    my $image_list_ref      = get_image_list($all);
    my $image_inspect_ref   = inspect_image($id);

# EXPORT

    get_image_ids
    get_image_list
    inspect_image
    read_image_ids

# SUBROUTINES

## **get\_image\_ids**

Return a list of the docker image ids

    my $ids_ref = get_image_ids();

## **get\_image\_list(ALL)**

Return a list of json data for each active docker image

`ALL` get all images (1) or active only images (0, default)

    my $image_list_ref = get_image_list($all);

## **inspect\_image(ID)**

Return json data for an inspection of the id  

`ID` docker image id to inspect

    my $image_inspect_ref = inspect_image($id);

# AUTHOR

Matt Martini, `<matt at imaginarywave.com>`

# BUGS

Please report any bugs or feature requests to `bug-app-docker-info at rt.cpan.org`, or through
the web interface at [https://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-Docker-Info](https://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-Docker-Info).  I will
be notified, and then you'll automatically be notified of progress on your bug as I make changes.

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::Docker::Info

You can also look for information at:

- RT: CPAN's request tracker (report bugs here)

    [https://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Docker-Info](https://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Docker-Info)

- Search CPAN

    [https://metacpan.org/release/App-Docker-Info](https://metacpan.org/release/App-Docker-Info)

# ACKNOWLEDGMENTS

# LICENSE AND COPYRIGHT

This software is Copyright © 2025-2026 by Matt Martini.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

# NAME

App::Docker::Info - Gathers information about docker images, containers, volumes, and system.

# VERSION

Version v0.2.0

# SYNOPSIS

App::Docker::Info provides a loader for sub-modules where a leading :: denotes a package to load.

    use App::Docker::Info qw( ::OS ::Utils );

This is equivalent to:

    user App::Docker::Info::OS    qw(:all);
    user App::Docker::Info::Utils qw(:all);

# SEE ALSO

[App::Docker::Info::Image](https://metacpan.org/pod/App%3A%3ADocker%3A%3AInfo%3A%3AImage),
[App::Docker::Info::Container](https://metacpan.org/pod/App%3A%3ADocker%3A%3AInfo%3A%3AContainer),
[App::Docker::Info::Volume](https://metacpan.org/pod/App%3A%3ADocker%3A%3AInfo%3A%3AVolume),
[App::Docker::Info::System](https://metacpan.org/pod/App%3A%3ADocker%3A%3AInfo%3A%3ASystem),

# AUTHOR

Matt Martini, `<matt.martini at imaginarywave.com>`

# BUGS

Please report any bugs or feature requests to `bug-dev-util at rt.cpan.org`, or through
the web interface at [https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dev-Util](https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dev-Util).  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

# INSTALLATION

To install this module, see `INSTALL.md`

TLDR; run the following commands:

    perl Makefile.PL
    make
    make test
    make install

# SUPPORT AND DOCUMENTATION

You can find documentation for this module with the perldoc command.

    perldoc Dev::Util

You can also look for information at:

- RT: CPAN's request tracker (report bugs here)

    [https://rt.cpan.org/NoAuth/Bugs.html?Dist=Dev-Util](https://rt.cpan.org/NoAuth/Bugs.html?Dist=Dev-Util)

- Search CPAN

    [https://metacpan.org/release/Dev-Util](https://metacpan.org/release/Dev-Util)

# HISTORY

This module was originally developed under the name `MERM::Base`.

# TEMPLATE

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

# ACKNOWLEDGMENTS

# LICENSE AND COPYRIGHT

This software is Copyright © 2024-2025 by Matt Martini.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

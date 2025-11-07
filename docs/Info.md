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

[App::Docker::Info::Syntax](https://metacpan.org/pod/App%3A%3ADocker%3A%3AInfo%3A%3ASyntax),
[App::Docker::Info::Utils](https://metacpan.org/pod/App%3A%3ADocker%3A%3AInfo%3A%3AUtils),

# DESCRIPTION

# CONFIGURATION AND ENVIRONMENT

App::Docker::Info requires no configuration files or environment variables.

# DEPENDENCIES

None.

# INCOMPATIBILITIES

None reported.

# BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
`bug-app-docker-info@rt.cpan.org`, or through the web interface at
[http://rt.cpan.org](http://rt.cpan.org).

# AUTHOR

Matt Martini  `<matt@imaginarywave.com>`

# LICENCE AND COPYRIGHT

This software is Copyright © 2024 by Matt Martini.

This is free software, licensed under:

    The GNU General Public License, Version 3, June 2007

# DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

# POD ERRORS

Hey! **The above document had some coding errors, which are explained below:**

- Around line 86:

    &#x3d;back without =over

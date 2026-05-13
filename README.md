# NAME
App::Docker::Info - Display information about current docker components

# VERSION
Version v0.13.0

# SYNOPSIS

This script gathers information about docker images, containers,  
volumes, networks, and system via docker list and inspect commands  
rendered as JSON.  

It is similar to doing docker list or inspect:
```
docker image inspect --format '{{json .}}' 6feeb73a8469 | jq
```
but, with filtering and formatting to make the output more useful.

# EXAMPLES

## List of docker images

`docker-info --image --list`

## List of docker container IDs

`docker-info --container --ids`

## List of docker networks, read from a json file

`docker-info --network --list --file network.list.json`

## Inspect a docker volume

`docker-info --volume --inspect 37895bc5b3fd`

## Help and Usage

`docker-info --help`

# SUB-MODULES
The sub-modules provide the functionality described below.  For more details see `perldoc <Sub-module_Name>`.

## App::Docker::Info
`App::Docker::Info` provides a loader for sub-modules where a leading `::` denotes a package to load.

    use App::Docker::Info qw( ::Image ::Volume );

This is equivalent to:

    use App::Docker::Info::Image  qw(:all);
    use App::Docker::Info::Volume qw(:all);

## App::Docker::Info::Utils

## App::Docker::Info::Image

## App::Docker::Info::Container

## App::Docker::Info::Volume

## App::Docker::Info::Network

## App::Docker::Info::System

# INSTALLATION

To install this module, run the following commands:

    perl Makefile.PL
    make
    make test
    make install

*Note: This will install the command `docker-info` into your path*

# SUPPORT AND DOCUMENTATION

After installing, you can find documentation for this module with the
perldoc command.

    perldoc App::Docker::Info

You can also look for information at:

- [RT, CPAN's request tracker (report bugs here)](https://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Docker-Info)

- [Search CPAN](https://metacpan.org/release/App-Docker-Info)

## Inspiration
This script was inspired by [docker-image-list.sh](https://github.com/rimelek/scripts-for-docker.git) created by: Ákos Takács (rimelek).

# COPYRIGHT AND LICENSE

Copyright © 2025-2026, Matt Martini  

See _LICENSE_ file for Software License.

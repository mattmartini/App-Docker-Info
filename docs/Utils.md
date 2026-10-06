# NAME

App::Docker::Info::Utils - Utilities for gathering and displaying Docker info

# VERSION

Version v0.21.0

# SYNOPSIS

App::Docker::Info::Utils - Support utilities for getting docker info, converting, and sorting it.

    use App::Docker::Info::Utils qw(:all);

    my $cmd = get_docker_cmd();
    my @image_list = pull_info('image list -q');

    my $sorted_ref = sort_array_ref($array_ref);
    my $hash_ref = json_to_hash_ref($json);

# EXPORT

    get_docker_cmd
    pull_info
    read_info
    sort_array_ref
    json_to_hash_ref
    aoj_to_aoh
    display_params

# SUBROUTINES

## **get\_docker\_cmd**

Returns the command path to the `docker` executable.  If the `docker` command is not found
this module and App can not be used, so it croaks.

    my $cmd = get_docker_cmd();

## **pull\_info**

Runs the docker command via `IPC_run_c` and returns the result.

    my @image_list = pull_info('image list -q');

## **read\_info**

Read a `JSON` file and return a reference to an array of its lines.

    my $array_ref = read_info('data.json');

## **sort\_array\_ref**

Testing helper. Alphabetical sort of an array ref. Docker returns `json` lists in 
indeterminate order, this functions normalizes the order so tests can pass

    my $sorted_ref = sort_array_ref($array_ref);

## **json\_to\_hash\_ref**

Takes a `JSON` string and returns a hash ref of it. 

    my $hash_ref = json_to_hash_ref($json);

## **aoj\_to\_aoh(AOJ)**

Convert an array of json data to an array of hashes

`AOJ` A reference to an array of json data

    my $aoh = aoj_to_aoh($aoj);

## **display\_params(PARAMS\_ARR\_REF)**

Display parameters from an array of hashes.  The hashes contain the value (`val`), 
condition (`cond`) whether it should be displayed, the color (`color`) it should be
displayed in, and the printf format (`fmt`)

`PARAMS_ARRAY_REF` A reference to array containg hashes as described above

    display_params($param_arr_ref);

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

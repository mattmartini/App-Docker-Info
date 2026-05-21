#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Network);
use Data::Printer;

plan tests => 3;

#======================================#
#             docker networks          #
#======================================#

my $cmd = get_docker_cmd();

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

#======================================#
#            get_network_ids           #
#======================================#
my $args = q{network list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = get_network_ids();

# p $ids_ref;
is( $ids_ref, $expected_ids_ref, "get_network_ids" );

#======================================#
#        get_active_network_list       #
#======================================#
$args = q{network list --format='{{json .}}'};

my $expected_network_list_ref = ipc_run($args);
my $network_list_ref          = get_active_network_list();

# p $network_list_ref;
is( $network_list_ref, $expected_network_list_ref,
    "get_active_network_list" );

#======================================#
#            inspect_network           #
#======================================#
$args = q{network inspect --format='{{json .}} '};
my $id = $ids_ref->[0];
$args .= $id;

my $expected_network_inspect_ref = ipc_run($args);
my $network_inspect_ref          = inspect_network($id);

# p $network_inspect_ref;
is( $network_list_ref, $expected_network_list_ref, "inspect_network" );

done_testing;

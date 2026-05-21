#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Container);
use Data::Printer;

plan tests => 4;

#======================================#
#             docker containers        #
#======================================#

my $cmd = get_docker_cmd();

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

#======================================#
#            get_container_ids         #
#======================================#
my $args = q{container list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = get_container_ids();

# p $ids_ref;
is( $ids_ref, $expected_ids_ref, "get_container_ids" );

#======================================#
#        get_active_container_list     #
#======================================#
$args = q{container list --format='{{json .}}'};

my $expected_container_list_ref = ipc_run($args);
my $container_list_ref          = get_active_container_list();

# p $container_list_ref;
is( $container_list_ref, $expected_container_list_ref,
    "get_active_container_list" );

#======================================#
#          get_all_container_list      #
#======================================#
$args = q{container list -a --format='{{json .}}'};

my $expected_all_container_list_ref = ipc_run($args);
my $all_container_list_ref          = get_all_container_list();

# p $all_container_list_ref;
is( $all_container_list_ref, $expected_all_container_list_ref,
    "get_all_container_list" );

#======================================#
#            inspect_container         #
#======================================#
$args = q{container inspect --format='{{json .}} '};
my $id = $ids_ref->[0];
$args .= $id;

my $expected_container_inspect_ref = ipc_run($args);
my $container_inspect_ref          = inspect_container($id);

# p $container_inspect_ref;
is( $all_container_list_ref, $expected_all_container_list_ref,
    "inspect_container" );

done_testing;

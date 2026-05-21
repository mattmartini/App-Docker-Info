#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';
use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Volume);
use Data::Printer;

plan tests => 4;

#======================================#
#             docker volumes           #
#======================================#

my $cmd = get_docker_cmd();

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

#======================================#
#            get_volume_ids            #
#======================================#
my $args = q{volume list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = get_volume_ids();

# p $ids_ref;
is( $ids_ref, $expected_ids_ref, "get_volume_ids" );

#======================================#
#        get_active_volume_list        #
#======================================#
$args = q{volume list --format='{{json .}}'};

my $expected_volume_list_ref = ipc_run($args);
my $volume_list_ref          = get_active_volume_list();

# p $volume_list_ref;
is( $volume_list_ref, $expected_volume_list_ref, "get_active_volume_list" );

#======================================#
#          get_all_volume_list         #
#======================================#
$args = q{volume list -a --format='{{json .}}'};

my $expected_all_volume_list_ref = ipc_run($args);
my $all_volume_list_ref          = get_all_volume_list();

# p $all_volume_list_ref;
is( $all_volume_list_ref, $expected_all_volume_list_ref,
    "get_all_volume_list" );

#======================================#
#            inspect_volume            #
#======================================#
$args = q{volume inspect --format='{{json .}} '};
my $id = $ids_ref->[0];
$args .= $id;

my $expected_volume_inspect_ref = ipc_run($args);
my $volume_inspect_ref          = inspect_volume($id);

# p $volume_inspect_ref;
is( $all_volume_list_ref, $expected_all_volume_list_ref, "inspect_volume" );

done_testing;

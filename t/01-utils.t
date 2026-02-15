#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util       qw(::Const ::OS);
use Dev::Util::File qw(file_executable);

use App::Docker::Info qw(::Utils);

plan tests => 3;

#======================================#
#            get_docker_cmd            #
#======================================#

my $docker_cmd = get_docker_cmd();
ok( file_executable($docker_cmd),
    "get_docker_cmd - docker cmd is executable." );

#======================================#
#              pull_info               #
#======================================#

my $cmd = $docker_cmd;

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

my $args = q{image list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = pull_info($args);

is( $ids_ref, $expected_ids_ref, "pull_info - get_image_ids" );

$args = q{image list --format='{{json .}}'};

my $expected_image_list_ref = ipc_run($args);
my $image_list_ref          = pull_info($args);

is( $image_list_ref, $expected_image_list_ref,
    "pull_info - get_active_image_list" );

done_testing;

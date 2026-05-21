#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Image);
use Data::Printer;

plan tests => 4;

#======================================#
#             docker images            #
#======================================#

my $cmd = get_docker_cmd();

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

#======================================#
#            get_image_ids             #
#======================================#
my $args = q{image list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = get_image_ids();

# p $ids_ref;
is( $ids_ref, $expected_ids_ref, "get_image_ids" );

#======================================#
#        get_active_image_list         #
#======================================#
$args = q{image list --format='{{json .}}'};

my $expected_image_list_ref = ipc_run($args);
my $image_list_ref          = get_active_image_list();

# p $image_list_ref;
is( $image_list_ref, $expected_image_list_ref, "get_active_image_list" );

#======================================#
#          get_all_image_list          #
#======================================#
$args = q{image list -a --format='{{json .}}'};

my $expected_all_image_list_ref = ipc_run($args);
my $all_image_list_ref          = get_all_image_list();

# p $all_image_list_ref;
is( $all_image_list_ref, $expected_all_image_list_ref, "get_all_image_list" );

#======================================#
#            inspect_image             #
#======================================#
$args = q{image inspect --format='{{json .}} '};
my $id = $ids_ref->[0];
$args .= $id;

my $expected_image_inspect_ref = ipc_run($args);
my $image_inspect_ref          = inspect_image($id);

# p $image_inspect_ref;
is( $all_image_list_ref, $expected_all_image_list_ref, "inspect_image" );

done_testing;

#!/usr/bin/env perl

use Test2::V0;
use Test::Output;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Image);
use Data::Printer;

plan tests => 5;

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
is(
    sort_array_ref($ids_ref),
    sort_array_ref($expected_ids_ref),
    "get_image_ids"
  );

#======================================#
#        get_image_list                #
#======================================#
$args = q{image list --no-trunc --format='{{json .}}'};

my $expected_image_list_ref = ipc_run($args);
my $image_list_ref          = get_image_list(0);

# p $image_list_ref;
is(
    sort_array_ref($image_list_ref),
    sort_array_ref($expected_image_list_ref),
    "get_image_list - active only"
  );

$args = q{image list -a --no-trunc --format='{{json .}}'};

my $expected_all_image_list_ref = ipc_run($args);
my $all_image_list_ref          = get_image_list(1);

is(
    sort_array_ref($all_image_list_ref),
    sort_array_ref($expected_all_image_list_ref),
    "get_image_list - all"
  );

#======================================#
#            inspect_image             #
#======================================#
$args = q{image inspect };
my $id = $ids_ref->[1];
$args .= $id;
$args .= q{ --format='{{json .}}'};

my $expected_image_inspect_ref = ipc_run($args);
my $image_inspect_ref          = inspect_image($id);

# p $image_inspect_ref;
is(
    sort_array_ref($image_inspect_ref),
    sort_array_ref($expected_image_inspect_ref),
    "inspect_image"
  );

#======================================#
#         display_image_ids            #
#======================================#
my $expected_display_ids;
$expected_display_ids .= sprintf "%s\n", $_ for $ids_ref->@*;

stdout_is( \&display_image_ids, $expected_display_ids,
           "display_image_ids" );

#======================================#
#         display_image_ids            #
#======================================#

display_image_list(1);

#======================================#
#         display_image_inspect        #
#======================================#
foreach my $iid ($ids_ref->@*) {
display_image_inspect($iid);
}

done_testing;

#!/usr/bin/env perl

use Test2::V0;
use Test::Output;
use lib 'lib';
use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Volume);
use Data::Printer;

# plan tests => 4;

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
is(
    sort_array_ref($ids_ref),
    sort_array_ref($expected_ids_ref),
    "get_volume_ids"
  );

#======================================#
#          get_volume_list             #
#======================================#
$args = q{volume list --format='{{json .}}'};

my $expected_volume_list_ref = ipc_run($args);
my $volume_list_ref          = get_volume_list(0);

# p $volume_list_ref;

is(
    sort_array_ref($volume_list_ref),
    sort_array_ref($expected_volume_list_ref),
    "get_volume_list - active only"
  );

#======================================#
#            inspect_volume            #
#======================================#
$args = q{volume inspect };
my $id = $ids_ref->[0];
$args .= $id;
$args .= q{ --format='{{json .}}'};

my $expected_volume_inspect_ref = ipc_run($args);
my $volume_inspect_ref          = inspect_volume($id);

# p $volume_inspect_ref;
is(
    sort_array_ref($volume_inspect_ref),
    sort_array_ref($expected_volume_inspect_ref),
    "inspect_volume"
  );

#======================================#
#         display_volume_ids           #
#======================================#
my $expected_display_ids;
$expected_display_ids .= sprintf "%s\n", $_ for $ids_ref->@*;

stdout_is( \&display_volume_ids, $expected_display_ids,
           "display_volume_ids" );

#======================================#
#         display_volume_ids           #
#======================================#

# display_volume_list();

done_testing;

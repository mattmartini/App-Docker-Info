#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::System);
use Data::Printer;

plan tests => 1;

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
#            get_system_info           #
#======================================#
my $args = q{system info  --format='{{json .}}'};

my $expected_info_ref = ipc_run($args);
my $info_ref          = get_system_info();

# TODO fix comparison need to remove these keys before comparison
# "NFd":141,
# "NFd":143,
# "NGoroutines":142,
# "NGoroutines":154,
# "SystemTime":"2026-05-16T22:58:26.187240161-04:00",
# "SystemTime":"2026-05-16T22:58:28.843677353-04:00",
# is( $info_ref, $expected_info_ref, "get_system_info" );

#======================================#
#            get_system_df             #
#======================================#
$args = q{system df  --format='{{json .}}'};

my $expected_df_ref = ipc_run($args);
my $df_ref          = get_system_df();

is( $df_ref, $expected_df_ref, "get_system_df" );

done_testing;

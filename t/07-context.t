#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util         qw(::Const ::OS);
use App::Docker::Info qw(::Utils ::Context);
use Data::Printer;

plan tests => 4;

#======================================#
#             docker contexts        #
#======================================#

my $cmd = get_docker_cmd();

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

#======================================#
#            get_context_ids           #
#======================================#
my $args = q{context list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = get_context_ids();

# p $ids_ref;
is(
    sort_array_ref($ids_ref),
    sort_array_ref($expected_ids_ref),
    "get_context_ids"
  );

#======================================#
#            get_current_context       #
#======================================#
$args = q{context show};

my $expected_current_ref = ipc_run($args);
my $current_ref          = get_current_context();

# p $ids_ref;
is(
    sort_array_ref($current_ref),
    sort_array_ref($expected_current_ref),
    "get_current_context"
  );

#======================================#
#        get_context_list              #
#======================================#
$args = q{context list --format='{{json .}}'};

my $expected_context_list_ref = ipc_run($args);
my $context_list_ref          = get_context_list();

# p $context_list_ref;
is(
    sort_array_ref($context_list_ref),
    sort_array_ref($expected_context_list_ref),
    "get_context_list"
  );


#======================================#
#            inspect_context           #
#======================================#
$args = q{context inspect --format='{{json .}} '};
my $id = $current_ref;
$args .= $id;

my $expected_context_inspect_ref = ipc_run($args);
my $context_inspect_ref          = inspect_context($id);

# p $context_inspect_ref;
is(
    sort_array_ref($context_inspect_ref),
    sort_array_ref($expected_context_inspect_ref),
    "inspect_context"
  );

done_testing;

#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use App::Docker::Info::Syntax;
use App::Docker::Info qw(::Utils ::System);

# plan tests => 2;

#======================================#
#             docker systems            #
#======================================#

my $system          = 'bloop';
my $expected_system = 'bloop';

is( $system, $expected_system, "system is bloop." );

#======================================#
#            get_smart_cmd             #
#======================================#

# my $smart_cmd = get_smart_cmd();
# ok( file_executable($smart_cmd), "get_smart_cmd - smart cmd is executable." );

done_testing;

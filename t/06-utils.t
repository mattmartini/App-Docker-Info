#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use App::Docker::Info qw(::Utils);

# plan tests => 2;

#======================================#
#             docker utilss            #
#======================================#

my $utils          = 'frozz';
my $expected_utils = 'frozz';

is( $utils, $expected_utils, "utils is frozz." );

#======================================#
#            get_smart_cmd             #
#======================================#

# my $smart_cmd = get_smart_cmd();
# ok( file_executable($smart_cmd), "get_smart_cmd - smart cmd is executable." );

done_testing;

#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use App::Docker::Info qw(::Network);

# plan tests => 2;

#======================================#
#             docker networks            #
#======================================#

my $network          = 'frozz';
my $expected_network = 'frozz';

is( $network, $expected_network, "network is frozz." );

#======================================#
#            get_smart_cmd             #
#======================================#

# my $smart_cmd = get_smart_cmd();
# ok( file_executable($smart_cmd), "get_smart_cmd - smart cmd is executable." );

done_testing;

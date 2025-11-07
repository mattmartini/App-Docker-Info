#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use App::Docker::Info::Syntax;
use App::Docker::Info qw(::Utils ::Volume);

# plan tests => 2;

#======================================#
#             docker volumes            #
#======================================#

my $volume          = 'frozz';
my $expected_volume = 'frozz';

is( $volume, $expected_volume, "volume is frozz." );

#======================================#
#            get_smart_cmd             #
#======================================#

# my $smart_cmd = get_smart_cmd();
# ok( file_executable($smart_cmd), "get_smart_cmd - smart cmd is executable." );

done_testing;

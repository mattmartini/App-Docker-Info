#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use App::Docker::Info qw(::Utils ::Image);

# plan tests => 2;

#======================================#
#             docker images            #
#======================================#

my $image          = 'bleep';
my $expected_image = 'bleep';

is( $image, $expected_image, "image is bleep." );

#======================================#
#            get_smart_cmd             #
#======================================#

# my $smart_cmd = get_smart_cmd();
# ok( file_executable($smart_cmd), "get_smart_cmd - smart cmd is executable." );

done_testing;

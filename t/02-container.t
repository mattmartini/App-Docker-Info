#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use App::Docker::Info qw(::Utils ::Container);

# plan tests => 2;

#======================================#
#             docker containers            #
#======================================#

my $container          = 'blorp';
my $expected_container = 'blorp';

is( $container, $expected_container, "container is blorp." );

#======================================#
#            get_smart_cmd             #
#======================================#

# my $smart_cmd = get_smart_cmd();
# ok( file_executable($smart_cmd), "get_smart_cmd - smart cmd is executable." );

done_testing;

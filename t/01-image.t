#!/usr/bin/env perl

use Test2::V0;
use lib 'lib';

use Dev::Util::Syntax;
use App::Docker::Info::Image;

# plan tests => 2;

#======================================#
#             docker images            #
#======================================#

my $image             = 'bleep';
my $expected_image    = 'bleep';
my $expected_image_re = qr{ble+p};

is( $image, $expected_image, "image is bleep." );
like( $image, $expected_image_re, "image like bleep." );

done_testing;

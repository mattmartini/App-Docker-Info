#!/usr/bin/env perl

use Test2::V0;
use Test::Output;
use lib 'lib';

use Dev::Util::Syntax;
use Dev::Util       qw(::Const ::OS);
use Dev::Util::File qw(file_executable);

use App::Docker::Info qw(::Utils);
use JSON::MaybeXS;

use Data::Printer;

plan tests => 7;

#======================================#
#            get_docker_cmd            #
#======================================#

my $docker_cmd = get_docker_cmd();
ok( file_executable($docker_cmd),
    "get_docker_cmd - docker cmd is executable." );

#======================================#
#              pull_info               #
#======================================#

my $cmd = $docker_cmd;

sub ipc_run {
    my $args = shift;
    my @lines = ipc_run_c(
                       { cmd => $cmd . $SPACE . $args, verbose => 0, timeout => 5 } );
    return \@lines;
}

my $args = q{image list -q};

my $expected_ids_ref = ipc_run($args);
my $ids_ref          = pull_info($args);

is(
    sort_array_ref($ids_ref),
    sort_array_ref($expected_ids_ref),
    "pull_info - get_image_ids"
  );

$args = q{image list --format='{{json .}}'};

my $expected_image_list_ref = ipc_run($args);
my $image_list_ref          = pull_info($args);

is(
    sort_array_ref($image_list_ref),
    sort_array_ref($expected_image_list_ref),
    "pull_info - get_image_list"
  );

#======================================#
#           sort_array_ref             #
#======================================#
my $expected_array_ref = [ 'a', 'b', 'c' ];
my $unsorted_array_ref = [ 'c', 'a', 'b' ];

is(
    $expected_array_ref,
    sort_array_ref($unsorted_array_ref),
    'sort_array_ref - sort reference to an array'
  );

#======================================#
#          json_to_hash_ref            #
#======================================#
my $expected_student_hash = { 'name'    => 'Foo Bar',
                              'email'   => 'foo@bar.com',
                              'gender'  => undef,
                              'address' => { 'planet' => 'Earth',
                                             'city'   => 'Fooville'
                                           },
                              'classes' => [ 'Chemistry', 'Math', 'Literature' ]
                            };

my $student_json
    = '{"classes":["Chemistry","Math","Literature"],"gender":null,"name":"Foo Bar","email":"foo@bar.com","address":{"city":"Fooville","planet":"Earth"}}';
my $student_hash = json_to_hash_ref($student_json);

is( $expected_student_hash, $student_hash, 'json_to_hash_ref' );

#======================================#
#          aoj_to_aoh                  #
#======================================#
# Array of json to Array of Hashes

my $expected_aoh = [
                     { name => 'Joe Cool',        address => '555 Dogouse Way' },
                     { name => 'Patek Philippe',  address => 'Geneve' },
                     { name => 'Vincent vanGogh', address => 'Arles' },
                   ];

my @aoj;
$aoj[0] = q/{"address":"555 Dogouse Way","name":"Joe Cool"}/;
$aoj[1] = q/{"address":"Geneve","name":"Patek Philippe"}/;
$aoj[2] = q/{"address":"Arles","name":"Vincent vanGogh"}/;

my $aoh = aoj_to_aoh( \@aoj );

is( $aoh, $expected_aoh, 'aoj_to_aoh' );

#======================================#
#          display_params              #
#======================================#

my $expected_display_params = q{[34m 0017 [0m[38;5;243m              show me
 [0m[31m         12 [0m[32m         77
 [0m};

my @values;
$values[0]
    = { val   => 17,
        cond  => 1,
        color => 'blue',
        fmt   => qq{ %0.4d }
      };
$values[1]
    = { val   => q{don't display me},
        cond  => 0,
        color => 'blue',
        fmt   => qq{ %s\n }
      };
$values[2]
    = { val => q{show me},
        fmt => qq{ %20s\n }
      };
$values[3]
    = { val   => 12,
        cond  => 12 > 5,
        color => 'red',
        fmt   => qq{ %10d }
      };
$values[4]
    = { val   => 77,
        color => 'green',
        fmt   => qq{ %10d\n }
      };

sub display_test {
    display_params( \@values );
    return;
}
stdout_is( \&display_test, $expected_display_params, "display_params" );

done_testing;

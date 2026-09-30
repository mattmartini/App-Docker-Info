use strict;
use warnings;
use Software::Security::Policy::Individual;
my $policy = Software::Security::Policy::Individual->new(
    {      maintainer => 'Matt Martini <matt.martini@imaginarywave.com>',
           program    => 'App::Docker::Info',
           timeframe  => '7 days',
           url => 'https://github.com/mattmartini/App-Docker-Info/blob/main/SECURITY.md',
           perl_support_years => '10',
    }
);
print $policy->fulltext, "\n";


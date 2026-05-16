use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'App::Docker::Info',
    DISTNAME           => 'App-Docker-Info',
    AUTHOR             => 'Matt Martini <matt@imaginarywave.com>',
    VERSION_FROM       => 'lib/App/Docker/Info.pm',
    ABSTRACT_FROM      => 'lib/App/Docker/Info.pm',
    LICENSE            => 'gpl_3',
    MIN_PERL_VERSION   => '5.018',
    PL_FILES           => {},
    BUILD_REQUIRES     => { 'ExtUtils::MakeMaker' => 0, },
    CONFIGURE_REQUIRES => { 'ExtUtils::MakeMaker' => 0, },
    EXE_FILES          => [ 'bin/docker-info', ],
    PREREQ_PM          => {
                       'Dev::Util'           => 2.16.0,
                       'Carp'                => 1.50,
                       'English'             => 0,
                       'Exporter'            => 0,
                       'JSON'                => 4.11,
                       'File::JSON::Slurper' => 1.00,
                       'Readonly'            => 2.05,
                       'Term::ANSIColor'     => 5.01,
                       'Term::ReadKey'       => 2.38,
                       'Test::More'          => 1.302219,
                       'autodie'             => 0,
                       'strict'              => 0,
                       'utf8'                => 0,
                       'version'             => 0,
                       'warnings'            => 0,
                 },
    TEST_REQUIRES => {     'English'            => 0,
                           'ExtUtils::Manifest' => 0,
                           'File::Compare'      => 1.1006,
                           'File::Path'         => 2.18,
                           'Path::Tiny'         => 0.148,
                           'Test2::V0'          => 1.302219,
                           'Test2::Tools::Ref'  => 1.302219,
                           'Test::More'         => 1.302219,
                     },
    MAN1PODS   => { 'bin/docker-info' => 'blib/man1/docker-info.1' },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {  repository => {
                                  type => 'git',
                                  url => 'https://github.com/mattmartini/App-Docker-Info.git',
                                  web => 'https://github.com/mattmartini/App-Docker-Info'
                          },
                     }
                  },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'App-Docker-Info-*' },
    ## NOECHO => '', # make debug output if empty
);

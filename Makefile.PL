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
                       'Dev::Util'       => 2.16.0,
                       'Carp'            => 0,
                       'English'         => 0,
                       'Exporter'        => 0,
                       'JSON'            => 0,
                       'Readonly'        => 0,
                       'Term::ANSIColor' => 0,
                       'Term::ReadKey'   => 0,
                       'Test::More'      => 0,
                       'autodie'         => 0,
                       'strict'          => 0,
                       'utf8'            => 0,
                       'version'         => 0,
                       'warnings'        => 0,
                 },
    TEST_REQUIRES => {     'English'            => 0,
                           'ExtUtils::Manifest' => 0,
                           'File::Compare'      => 0,
                           'File::Path'         => 0,
                           'FindBin'            => 0,
                           'Socket'             => 0,
                           'Test2::V0'          => 0,
                           'Test2::Tools::Ref'  => 0,
                           'Test::More'         => 0,
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

#Place where application will live

# RPM's we need 
default[:pkgs686] = [ 'libtool-ltdl-devel', 'alsa-lib',  'ncurses-libs', 'ncurses-devel', 'glibc', 'alsa-lib', 'libgcc', 'compat-libstdc++-33' ]
default[:pkgsx64] = [ 'zlib-devel', 'libxml2-devel', 'libxslt', 'libxslt-devel' ]
# Iheart RPMS
default[:iheart_pkg] = [ 'jdk', 'mpg123',  'sox', 'lame-libs', 'libmad-devel', 'libmad'  ]

default[:jruby_gems] =  {
     "ruby-mp3info" => "0.7.1",
     "activerecord-jdbc-adapter" => "1.2.2",
     "jdbc-postgres" => "9.1.901",
     "activerecord-jdbcpostgresql-adapter" => "1.2.2",
     "tmail" => "1.2.7.1",
     "nokogiri" => "1.5.0",
     "rake" => "0.8.7",
     "uits" => "0.0.0",
     "bouncy-castle-java" => "1.5.0146.1",
     "jruby-openssl" => "0.7.7",
     "spoon" => "0.0.1",
     "bundler" => "1.1.5"
}

default[:gems] = {
    "akami" => "1.2.0",
    "ffi" => "1.2.0",
    "postgres-pr" => "0.6.3",
    "nori" => "2.0.4",
    "rack" => "1.5.2",
    "rails" => "3.2.13",
    "httpi" => "2.0.2",
    "wasabi" => "3.0.0",
    "builder" => "3.2.0",
    "gyoku" => "1.0.0",
    "akami" => "1.2.0",
    "savon" => "2.1.0",
    "libxml-ruby" => "2.6.0",
    "uits" => "0.0.0",
    "activerecord-jdbc-adapter" => "1.2.2",
    "activerecord-jdbcpostgresql-adapter" => "1.2.2",
    "bouncy-castle-java" => "1.5.0146.1",
    "bundler" => "1.1.5",
    "jdbc-postgres" => "9.1.901",
    "jruby-openssl" => "0.7.7",
    "nokogiri" => "1.5.0",
    "rake" => "0.8.7",
    "ruby-mp3info" => "0.7.1",
    "sources" => "0.0.1",
    "spoon" => "0.0.1",
    "tmail" => "1.2.7.1"
    }

default[:encoders][:static_files] = { 
    "/usr/local/bin/lame" => "lame",
    "/usr/local/bin/aacPlusEnc" => "aacPlusEnc"
}


default[:encoders][:source_dir] = [ "/data/" ]
default[:encoders][:github_url] = [ "git@github.com:iheartradio/converter.git" ]
default[:encoders][:github_user] = [ "github" ]
default[:encoders][:converter_user] = [ "converter" ]

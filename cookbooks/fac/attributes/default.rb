default[:fac][:PRN][:version] = "3.4.62"
default[:fac][:talk][:version] = "3.4.120"
default[:fac][:music][:version] = "3.4.98"
default[:fac][:sherpa][:version] = "3.4.94"
default[:fac][:sherpa][:jarfile] = "FAC-sherpa"
default[:fac][:radiobuild][:version] = "1.0.22"
default[:fac][:radiobuild2][:version] = "1.0.23"
default[:fac][:recommendations][:version] = "3.4.94"
default[:fac][:genre][:version] = "3.4.110"

default[:fac][:es_vip] = "iad-search-vip-v200.ihr:9200"
default[:fac][:script_path] = "/data/jobs/fac"
default[:fac][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/fac"
default[:fac][:files_url] = "http://files.ihrdev.com/fac"
default[:fac][:radiobuild][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/radio"
default[:fac][:radiobuild][:echonest] = "http://yum.ihr/files/ten.915.gz"
default[:fac][:radiobuild2][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/radio"
default[:fac][:radiobuild2][:echonest] = "http://yum.ihr/files/ten.915.gz"
default[:fac][:recommendations][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/fac"
default[:fac][:recommendations][:echonest] = "http://yum.ihr/files/ten.915.gz"

default[:fac][:amptools][:repo] = "git@github.com:iheartradio/amp-tools.git"

default[:fac][:genre][:radioedit][:rpc_url] = "iad-radioedit-test101.ihr/api/rpc"
default[:fac][:genre][:radioedit][:api_key] = "T2R6dFl2MXY4bA=="

# GP EDIT OPS-5083
default[:fac][:etl_notify] = %w{ jeremybraff@clearchannel.com kengilmer@clearchannel.com gregorypatmore@clearchannel.com }

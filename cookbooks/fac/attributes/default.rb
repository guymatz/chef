default[:fac][:PRN][:version] = "3.4.22"
default[:fac][:talk][:version] = "3.4.38"
default[:fac][:music][:version] = "3.4.48"
default[:fac][:sherpa][:version] = "3.4.44"
default[:fac][:sherpa][:jarfile] = "FAC-sherpa"
default[:fac][:radiobuild][:version] = "1.0.12"
default[:fac][:radiobuild2][:version] = "1.0.15"

default[:fac][:script_path] = "/data/jobs/fac"
default[:fac][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/fac"
default[:fac][:files_url] = "http://files.ihrdev.com/fac"
default[:fac][:radiobuild][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/radio"
default[:fac][:radiobuild][:echonest] = "http://yum.ihr/files/ten.915.gz"
default[:fac][:radiobuild2][:url] = "http://archiva.ihrdev.com:8080/archiva/repository/internal/com/ccrd/radio"
default[:fac][:radiobuild2][:echonest] = "http://yum.ihr/files/ten.915.gz"

default[:fac][:amptools][:repo] = "git@github.com:iheartradio/amp-tools.git"

# GP EDIT OPS-5083
default[:fac][:etl_notify] = %w{ jeremybraff@clearchannel.com kengilmer@clearchannel.com gregorypatmore@clearchannel.com }

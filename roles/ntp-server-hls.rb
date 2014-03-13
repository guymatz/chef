name "ntp-server-hls"
description "NTP Server"
default_attributes ({
  "ntp" => ({
      "is_server" => "true",
      "servers" => ["0.pool.ntp.org", "1.pool.ntp.org"],
      "peers" => ["iad-hls1-admin101.ihr", "iad-hls1-admin102.ihr"],
      "restrictions" => ["10.5.57.0 mask 255.255.255.0 nomodify notrap"]
   })
})

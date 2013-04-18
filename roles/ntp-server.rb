name "ntp-server"
description "NTP Server"
default_attributes ({
  "ntp" => {
      "is_server" => "true",
      "servers" => ["0.pool.ntp.org", "1.pool.ntp.org"],
      "peers" => ["ntp101.ihrdev.com", "ntp102.ihrdev.com"],
      "restrictions" => ["10.0.0.0 mask 255.0.0.0 nomodify notrap"]
    }
})

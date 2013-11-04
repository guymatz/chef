module Helper
    def add_to_ftpasswd(user, user_info, pwd_file)
      user_entry = create_passwd_entry(user, user_info)
      return if user_exists?(user_entry, pwd_file)
      write_user_to_file(user_entry, pwd_file)
    end

    def create_passwd_entry(user, user_info)
      pwd = user_info['password']
      # Convert pwd to a crypted MD5 hash
      pwd = hash_pwd(pwd)
      uid = user_info['uid']
      gid = uid
      home_dir = user_info[:home_dir]
      shell = user_info[:shell]
      pwd_entry = "#{user}:#{pwd}:#{uid}:#{gid}::#{home_dir}:#{shell}\n"
      return pwd_entry
    end

    def user_exists?(user_entry, pwd_file)
      results = []
      begin
        results = open(pwd_file) { |f| f.grep(/#{Regexp.escape(user_entry)}/) }
      rescue
        Chef::Log.error("Could not open #{pwd_file}")
      end
      return true if results.size > 0
      return false
    end

    def write_user_to_file(user_entry, pwd_file)
      Chef::Log.info("Adding #{user_entry}")
      File.open(pwd_file, "a+") { |f|
        Chef::Log.info("Adding #{user_entry}")
        f.write(user_entry)
      }
    end

    def hash_pwd(pwd) 
    	# Leaving out the randomness for now to make comparisons of 
    	# entries easier
  		##@# seeds = ('a'..'z').to_a
  		##@# seeds.concat( ('A'..'Z').to_a )
  		##@# seeds.concat( (0..9).to_a )
  		##@# seeds.concat ['/', '.']
  		##@# seeds.compact!
  		##@# salt_string = '$1$'
  		##@# 8.times { salt_string << seeds[ rand(seeds.size) ].to_s }
      salt_string = '$1$iheartrd'

      # Crypt a password suitable for use in shadow files
      pwd.crypt( salt_string )  
    end
  
end
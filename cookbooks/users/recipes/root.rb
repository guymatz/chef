

directory "/root/.ssh" do
  owner "root"
  group "root"
  mode "0600"
end

oper_keys = []
search(:users, "groups:sysadmin") do |oper|
  unless oper['ssh_keys'].nil?
    if oper['ssh_keys'].kind_of?(Array)
      oper['ssh_keys'].each do |k|
        oper_keys << "#key for #{oper['id']}\n#{k}\n\n"
      end
    elsif oper['ssh_keys'].kind_of?(String)
      oper_keys << "#key for #{oper['id']}\n#{oper['ssh_keys']}\n\n"
    end
  end
end

file "/root/.ssh/authorized_keys" do
  content oper_keys.join("\n")
  owner "root"
  group "root"
  mode "0400"
end

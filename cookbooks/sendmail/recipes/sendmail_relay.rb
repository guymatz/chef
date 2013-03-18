cookbook_file "/etc/mail/sendmail.mc" do
  source "sendmail_relay"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, "service[sendmail]"
end


  template "/etc/init.d/S10hadoop-patch" do
    source "S10hadoop-patch.erb"
    mode 0775
    variables(
    )
  end


  link "/etc/rc.d/rc5.d/S10hadoop-patch" do
    to "/etc/init.d/S10hadoop-patch"
  end

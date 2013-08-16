# Set noop as the IO scheduler for vmware guests
if node.attribute?('virtualization') && node[:virtualization][:system] == 'vmware' && ode[:virtualization][:role] == 'guest'
  execute 'set-noop' do
    command <<-EOH
    echo noop > /sys/block/sda/queue/scheduler
    sed -i 's/rhgb quiet\n/rhgb quiet elevator=noop\n/g' /boot/grub/menu.lst
    EOH
  end
end

# Set noop as the IO scheduler for vmware guests
if node.attribute?('virtualization') && node[:virtualization][:system] == 'vmware' && node[:virtualization][:role] == 'guest'
  execute 'set-noop' do
    command 'echo noop > /sys/block/sda/queue/scheduler'
  end
  ruby_block 'set grub noop' do
    block do
      grub_txt = Array.new
      File.open('/boot/grub/menu.lst', 'r') {|f| grub_txt = f.readlines }
      unless grub_txt.to_s.include?('elevator=noop')
        grub_txt.each do |x|
          grub_txt[grub_txt.index(x)] = x.gsub(/\n/, ' elevator=noop') if x.include?('kernel')
        end
        File.open('/boot/grub/menu.lst', 'w') {|f| grub_txt.each { |x| f.puts(x) }}
      end
    end
  end
end

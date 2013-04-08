
node[:memcached][:monitoring][:packages].each do |p|
  package p
end


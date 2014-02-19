node[:gems].each do |gem,ver|
  gem_package gem do
    action :install
    options "--no-ri --no-rdoc"
    version ver
  end
end

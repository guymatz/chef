# add sudo for trey long
sudo "tlong" do
  user "tlong"
  commands ["ALL"]
  runas "root"
  nopasswd true
end

sudo "tterry" do
  user "tterry"
  commands ["ALL"]
  runas "root"
  nopasswd true
end

sudo "ikaprizkina" do
  user "ikaprizkina"
  commands ["ALL"]
  runas "root"
  nopasswd true
end
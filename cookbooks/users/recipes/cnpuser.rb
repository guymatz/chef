# #######################################################
# @CREATED 7/26/13 
# @AUTHOR Gregory Patmore
# @CONTACT gregorypatmore@clearchannel.com
# @DESC CNP Users Group
# @REF https://jira.ccrd.clearchannel.com/browse/OPS-4601
# 
# #######################################################
users_manage "cnpuser" do
  group_id 5039
  action [ :remove, :create ]
end

sudo "cnpuser" do
  group "cnpuser"
  commands ["ALL"]
  runas "names"
  nopasswd true
end

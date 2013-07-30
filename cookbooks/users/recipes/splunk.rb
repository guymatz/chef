# #######################################################
# @CREATED 7/26/13 
# @AUTHOR Gregory Patmore
# @CONTACT gregorypatmore@clearchannel.com
# @DESC Logging Client Group
# @REF https://jira.ccrd.clearchannel.com/browse/OPS-4884
# 
# #######################################################
users_manage "splunk" do
  group_id 4000
  action [ :remove, :create ]
end
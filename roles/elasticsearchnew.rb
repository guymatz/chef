name "elasticsearchnew"
description "Elastic Search New"
default_attributes "java" => {
  "jdk_version" => "7"
}
run_list(
         "recipe[java]",
         "recipe[elasticsearchnew]",
	 "recipe[elasticsearchnew::plugins]",
	 "recipe[elasticsearchnew::backup_client]"
)

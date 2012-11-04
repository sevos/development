require 'ostruct'

deploy_user_home = '/home/deploy'
deployers = data_bag("deployers").map { |user|
  user_data = data_bag_item("deployers", user)
  OpenStruct.new(:name => user_data['full_name'], :key => user_data['ssh_key'])
}

user "deploy" do
  comment "Deployment user"
  uid 2000
  gid "users"
  home deploy_user_home
  shell "/bin/bash"
end

directory deploy_user_home do
  owner "deploy"
  group "users"
  mode "0711"
  action :create
end

directory "#{deploy_user_home}/.ssh" do
  owner "deploy"
  group "users"
  mode "0711"
  action :create
end

file "#{deploy_user_home}/.ssh/authorized_keys" do
  action :create
end

template "#{deploy_user_home}/.ssh/authorized_keys" do
  source "authorized_keys.erb"
  mode "0644"
  variables(:deployers => deployers)
end

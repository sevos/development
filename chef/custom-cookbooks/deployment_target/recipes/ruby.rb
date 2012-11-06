node.override[:rvm] = {
    'user_installs' => [
        {
            'user' => 'deploy',
            'default_ruby' => node[:ruby][:version],
            'rubies' => [],
        }
    ],
    'user_global_gems' => [
        { 'name' => 'bundler' }
    ]
}

include_recipe 'rvm::user'

# Database comfig
directory '/home/deploy/shared' do
  owner 'deploy'
  action :create
end

directory '/home/deploy/shared/config' do
  owner 'deploy'
  action :create
end

template '/home/deploy/shared/config/database.yml' do
  source "database.yml.erb"
  owner 'deploy'
  mode "0644"
  variables(:environment => node[:application][:environment],
            :database => node[:application][:database])
end

include_recipe 'nginx::source', 'nginx::http_gzip_static_module'

template "/etc/nginx/sites-enabled/000-default" do
  source 'nginx-vhost.erb'
  owner "www-data"
  group "users"
  mode "0644"
  notifies :reload, "service[nginx]"
end


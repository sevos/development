node.override[:rvm] = {
    'user_installs' => [
        {
            'user' => 'deploy',
            'default_ruby' => node[:ruby][:version],
            'rubies' => []
        }
    ]
}

include_recipe 'rvm::user'

# Database comfig
directory '/home/deploy/shared' do
  action :create
end

directory '/home/deploy/shared/config' do
  action :create
end

template '/home/deploy/shared/config/database.yml' do
  source "database.yml.erb"
  owner 'deploy'
  mode "0644"
  variables(:environment => node[:application][:environment],
            :database => node[:application][:database])
end

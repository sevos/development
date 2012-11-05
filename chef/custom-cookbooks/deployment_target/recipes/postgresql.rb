node['databases'].each do |db_config|
  pg_user db_config['username'] do
    privileges :superuser => false, :createdb => false, :login => true
    password db_config['password']
  end

  pg_database db_config['name'] do
    owner db_config['username']
    encoding "utf8"
    template "template0"
    locale "en_US.UTF8"
  end
end
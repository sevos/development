name 'database-postgresql'
description 'installs postgresql database'

run_list 'recipe[postgresql::server]'

config = {
  :password => { :postgres => 'qwerty' },
  :listen_addresses => ['*'],
  :hba => [
    {:address => 'all', :method => 'md5'}
  ]
}

override_attributes :postgresql => config

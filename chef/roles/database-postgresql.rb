name 'database-postgresql'
description 'installs postgresql database'

run_list 'recipe[postgresql::server]', 'recipe[deployment_target::postgresql]'

config = {
  :listen_addresses => ['*'],
  :pg_hba => [
    'host    all             all             192.168.69.0/24            md5'
  ]
}

override_attributes :postgresql => config

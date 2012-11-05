name 'ruby-deployment-target'

run_list 'role[deployment-target]',
         'recipe[deployment_target::ruby]',
         'recipe[postgresql::client]', 'recipe[postgresql::libpq]',
         'recipe[nodejs]' # for js runtime

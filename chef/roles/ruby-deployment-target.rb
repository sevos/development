name 'ruby-deployment-target'

run_list 'role[deployment-target]', 'recipe[deployment_target::ruby]'

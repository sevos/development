# Installing required git core-packages
package 'git-core' do
  action :install
  options '--force-yes'
end

# Retrieving admins collection
admins = data_bag("admins")

# admins list round-trip
admins.each do |login|
  admin = data_bag_item("admins", login)
  home = "/home/#{login}"

  vimfiles_repo = admin['vimfiles_repository']

  if vimfiles_repo = admin['vimfiles_repository']
    log "[vimfiles] Uploading vimfiles for #{admin} from #{vimfiles_repo} to #{home}/.vim " do
      level :info
    end

    git "#{home}/.vim" do
      repository vimfiles_repo
      action :sync
      enable_submodules true
      user login
      group login
      only_if {File.directory?(home)}
    end
  end
end

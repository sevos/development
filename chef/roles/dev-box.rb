name 'dev-box'
description 'installs developers environment'

run_list 'recipe[tmux]', 'recipe[ctags]',
         'recipe[vim]', 'recipe[vim::vimfiles]',
         'recipe[git]', 'recipe[curl]',
         'recipe[dotfiles]'


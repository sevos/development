name "ruby-development"
description "installs rvm and given ruby version for vagrant user"

run_list "recipe[rvm::user]"

default_attributes(
  'rvm' => {
    'user_installs' => [
      {
        'user' => 'vagrant',
        'default_ruby' => '1.9.2',
        'rubies' => []
      }
    ]
  }
)


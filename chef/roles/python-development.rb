name "python-development"
description "installs python"

run_list "recipe[python]", "role[dev-box]"

# devstuff
Local development setup using vagrant for virtual machines and ansible for server setup.

Both folders have [vagrantfile](ubuntu/Vagrant) for multi node/server setup and using ansible to setup the machines.
- [ubuntu-folder](ubuntu)
- [centos-folder](ubuntu)

To choose how many nodes you want edit the variable `NODE_COUNT` in [vagrantfile](ubuntu/Vagrant) and if you choos zero if one node called master.

There are also ansible-playbooks to setup jenkins mainly to use ansible with masters node defined in [vagrantfile](ubuntu/Vagrant) and other playbook.

- [jenkins](jenkins)
- [foreman](foreman)
- [nodejs](node-install.yml)
- [confluence](confluence)

There is also some example terraform setup.

-[terraform](terraform)

When to try out a terraform config you an use this script [gettf](gettf) to copy 
terraform examples to your home folder.


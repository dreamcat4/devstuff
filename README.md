# devstuff
Local development setup using vagrant for virtual machines and ansible for server setup.

Both folders have [vagrantfile](ubuntu/Vagrant) for multi node/server setup and using ansible to setup the machines.
- [ubuntu-folder](ubuntu)
- [centos-folder](ubuntu)

To choose how many nodes you want edit the variable `NODE_COUNT` in [vagrantfile](ubuntu/Vagrant) and if you choose zero it will make one node called master.

There are also ansible-playbooks to setup jenkins mainly to test out ansible with masters node defined in [vagrantfile](ubuntu/Vagrant) and the other os playbooks.

- [jenkins](ansible/jenkins)
- [foreman](ansible/foreman)
- [nodejs](ansible/node-install.yml)
- [confluence](ansible/confluence)

There is also some example terraform setup.

-[terraform](terraform)

When to try out a terraform config you an use this script [gettf](gettf) to copy 
terraform examples to your home folder.


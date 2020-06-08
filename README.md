# devstuff
development setup with vagrant, docker, ansible and other.

Both folders have [vagrantfile](ubuntu/Vagrant) for multi node/server setup and and ansible to setup the machines.
- [ubuntu-folder](ubuntu)
- [centos-folder](ubuntu)

To choose how many nodes you want edit the variable `NODE_COUNT` and if you choos zero it will only setup the master.

There are also ansible-playbooks to setup jenins mainly to use ansible with masters node defined in [vagrantfile](ubuntu/Vagrant) and foreman install playbook.

- [jenkins](jenkins)
- [foreman](foreman)


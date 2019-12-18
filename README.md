
#Takipi Ansible Playbook

###Run the full test using Vagrant + VirtualBox
- the main configuration is saved in the host.json ( 4 hosts )
- the default Vagrantfile picks base boxes and name them accordingly

The command to use to build all the boxes is:
```vagrant up```

The general command to use to build a single box is:
```vagrant up <BOX_NAME>```

i.e. to deploy centos_7 box use the command:
```vagrant up centos_7```

###Run the playbook against you server using:

```ansible-playbook -i inventory site.yml```

Add your host in inventory.ini like:
```
[remote]
example.com 	ansible_ssh_user=root
```

Add your variables values in roles/common/vars/main.yml or group_vars/all.yml (defaults are included already in defaults/main.yml). There are few variables to consider:

- takipi - this contains the OverOps Host details
```
takipi:
  # OOMODE can be either:
  #    remoteAgent - for Agent ONLY pointing to a remote collector ip/port ( default )
  #    remoteCollector - for remote Collector
  #    localCollector - for local Collector + Agent
  #
  # Examples:
  #
  # OOMODE:
  #  mode: "remoteAgent"
  #  coll:
  #    ip: "10.0.1.200"
  #    port: 6060
  #
  # OOMODE:
  #  mode: "remoteCollector"
  #  coll:
  #    ip: ""
  #    port: 6060   # listening tcp port
  #
  # OOMODE:
  #  mode: "localCollector"
  #  coll:
  #    ip: ""       # this is set to "127.0.0.1"
  #    port: 6060   # this is both used for collector binging port and agent port
  OOMODE:
    mode: "remoteAgent"
    coll:
      ip: "10.0.1.1"
      port: 6060

  # OOINSTALLMODE can be either:
  #    package - for yum/apt
  #    tarball - for tarball
  OOINSTALLMODE: "tarball"
```

- takipiSK - this contains the OverOps Service Key
```
takipiSK:
  SECRET_KEY: "<Insert your secret key here>"
```

- takipiInternal - this is for internal use ( do not modify UNLESS YOU REALLY KNOW WHAT YOU ARE DOING )
```
takipiInternal:
  # do not modify UNLESS YOU REALLY KNOW WHAT YOU ARE DOING
```



Tested on:
- boxes OS ( also for Vagrant guests )
    - Ubuntu 16.04, 18.04
    - CentOS 7, 8
- Vagrant 2.2.6
	- (patched to work with VirtualBox 6.1 ref: https://github.com/oracle/vagrant-boxes/issues/178#issue-536720633 )
- VirtualBox 6.1
- Ansible 2.9.2

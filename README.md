#Takipi Ansible Playbook

###Run the playbook against you server using:

``ansible-playbook -i inventory site.yml``

Add your host in inventory.ini like:
```
[remote]
example.com 	ansible_ssh_user=root
```

Add your API Key in roles/common/vars/main.yml or group_vars/all.yml:
```
takipi:
  SECRET_KEY: "<Insert your secret key here>"
```

Tested on:
- Ubuntu 14.04, 12.04
- Ansible 1.7.2, 1.8.2
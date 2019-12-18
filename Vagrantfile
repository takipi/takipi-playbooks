# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set required vagrant version to run this vagrantfile
Vagrant.require_version ">= 1.4.3"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Require JSON module
require 'json'

BASE_IP = "10.0.1."
# Read YAML file with box details
HOSTS = JSON.parse(File.read(File.join(File.dirname(__FILE__), 'hosts.json')))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	HOSTS.each_with_index do |i,index|
	  config.vm.define i['name'] do |node|
	    node.vm.box = "#{i['name'].sub '_', '/'}"

	    # The url from where the 'node.vm.box' box will be fetched if it
	    # doesn't already exist on the user's system.

	    node.vm.hostname = "#{i['name'].sub '_',''}"
			node.vm.network "private_network", ip: "#{i['hostip']}"

	    # Share an additional folder to the guest VM. The first argument is
	    # the path on the host to the actual folder. The second argument is
	    # the path on the guest to mount the folder. And the optional third
	    # argument is a set of non-required options.
	    node.vm.synced_folder "~/", "/host-home"
	    node.vm.synced_folder ".", "/vagrant"

	    # Provider-specific configuration so you can fine-tune various
	    # backing providers for Vagrant. These expose provider-specific options.
	    node.vm.provider "virtualbox" do |vb|
	      # Don't boot with headless mode
	      # vb.gui = true

	      # specify vm name
	      vb.name = "takipi-#{i['name']}-env"

	      # Use VBoxManage to customize the VM. For example to change memory:
	      vb.customize ["modifyvm", :id, "--memory", "1024"]
	      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]

	      # The following allows symlinks in shared folders when running on windows host.
	      # vagrant must be run from a command prompt with admin privileges
	      if RUBY_PLATFORM == "i386-mingw32"
	        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
	        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/code", "1"]
	      end

	    end

	    node.vm.provision :ansible do |ansible|
				ansible.playbook = "site.yml"
	      ansible.verbose = "vv"
				ansible.extra_vars = {
					"takipi" =>  {
						"SECRET_KEY" => "S27571#sRk0xej3CHW8epq7#w1Mo879MTFaWhhCt61ZUy+OZRMOJeBanYshvKNIW5Hc=#7116",
						"OOMODE" => {
							"mode" => "#{i['takipi']['OOMODE']['mode']}" ,
							"coll" => {
								"ip" => "#{i['takipi']['OOMODE']['coll']['ip']}",
								"port" => "#{i['takipi']['OOMODE']['coll']['port']}",
							}
						},
						"OOINSTALLMODE" => "#{i['takipi']['OOINSTALLMODE']}"
					}
				}
			end
	  end

	end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set required vagrant version to run this vagrantfile
Vagrant.require_version ">= 1.4.3"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	["centos_6", "centos_7", "ubuntu_trusty64", "ubuntu_xenial64"].each do |i|
	  config.vm.define "#{i}" do |node|
	    node.vm.box = "#{i.sub '_', '/'}"
	    
	    # The url from where the 'node.vm.box' box will be fetched if it
	    # doesn't already exist on the user's system.
	        
	    node.vm.hostname = "takipi-dev"
	    
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
	      vb.name = "takipi-#{i}-env"
	       
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
	    
	    # Enable provisioning via Shell script.
	    #node.vm.provision "shell", path: "run-ansible-dev.sh", privileged: false, keep_color: true
	    node.vm.provision :ansible do |ansible|
	      ansible.playbook = "site.yml"
	      ansible.verbose = "vvv"
	      ansible.groups = {
	        "takipi" => ["local"],
	        "takipi:vars" => {"SECRET_KEY" => "S25327#evlYIBTPgZxlhoor#Zk7vFImQvCNfWPZOQs/HS9IXo1IsF1cT/6jXIg48SVc=#08db",
	        }
	      }
	    end
	
	  end

	end
end

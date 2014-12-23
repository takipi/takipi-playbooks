# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set required vagrant version to run this vagrantfile
Vagrant.require_version ">= 1.4.3"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "devel", primary: true do |devel|
    devel.vm.box = "centos65-x86_64-20140116"
    
    # The url from where the 'devel.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
    devel.vm.box_url = [
      "~/boxes/centos65-x86_64-20140116.box",
      "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"
    ]
        
    devel.vm.hostname = "takipi-dev"
    
    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    devel.vm.synced_folder "~/", "/host-home"
    devel.vm.synced_folder "../vagrant", "/vagrant"
    
    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    devel.vm.provider "virtualbox" do |vb|
      # Don't boot with headless mode
      # vb.gui = true
      
      # specify vm name
      vb.name = "takipi-devel-env"
       
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
    devel.vm.provision "shell", path: "run-ansible-dev.sh", privileged: false, keep_color: true
  end
end

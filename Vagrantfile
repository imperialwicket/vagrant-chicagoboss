# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |cb|

  # Base box - Ubuntu 12.04lts 
  cb.vm.box = "base"
  cb.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Set the name to avoid defaults
  cb.vm.hostname = "chicagoboss"
  cb.vm.define "chicagoboss" do |cb|
  end

  # Forward 8001 (CB's port) to local 8881
  cb.vm.network :forwarded_port, guest: 8001, host: 8881

  # Sync the app from vagrant user home to ../chicagoboss
  cb.vm.synced_folder "../chicagoboss", "/home/vagrant/chicagoboss"

  # Configuring with shell for simplicity
  cb.vm.provision "shell", path: "bootstrap.sh"

  # Up memory (building Erlang takes forever, feel free to reduce after
  # provisioning completes).
  cb.vm.provider :virtualbox do |vb|
    #vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    # Rename the virtualbox machine name
    vb.name = "chicagoboss"
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Provisioning with bash
$script = <<SCRIPT

if [[ "$(which erl)" == "/usr/local/bin/erl" ]]; then
  echo "Erlang present, skipping installation."
else
  echo "Installing Erlang..."
  echo "(This will take several minutes)"
  apt-get update
  apt-get -y install build-essential m4 libncurses5-dev libssh-dev unixodbc-dev libgmp3-dev libwxgtk2.8-dev libglu1-mesa-dev fop xsltproc default-jdk git
  mkdir -p /usr/src/erlang
  cd /usr/src/erlang
  wget http://www.erlang.org/download/otp_src_R15B02.tar.gz
  tar -xvzf otp_src_R15B02.tar.gz
  cd otp_src_R15B02
  ./configure
  make
  make install
fi

if [ -d /home/vagrant/chicagoboss/ChicagoBoss ]; then
  echo "ChicagoBoss present, skipping installation."
else
  echo "Installing Chicago Boss..."
  mkdir /home/vagrant/chicagoboss
  cd /home/vagrant/chicagoboss/
  git clone https://github.com/ChicagoBoss/ChicagoBoss.git
  cd ChicagoBoss
  git checkout "0d99199"
  ./rebar get-deps
  # hack because 0d99199 seems buggy (rolling back to erlydtl 0.8.0)
  sed -i 's/0.8.2/0.8.0/' rebar.config deps/boss_db/rebar.config
  sed -i '/erlydtl/ s/"HEAD"/{tag,"0.8.0"}/' deps/boss_db/rebar.config
  rm -rf /home/vagrant/chicagoboss/ChicagoBoss/deps/erlydtl
  ./rebar get-deps
  # end hack
  ./rebar compile
  chown -R vagrant:vagrant /home/vagrant/chicagoboss/
fi


cat << EOF


Chicago Boss installed at /home/vagrant/chicagoboss/ChicagoBoss.

To create an application, use 'vagrant ssh' to connect, then:
  cd /home/vagrant/chicagoboss/ChicagoBoss
  make app PROJECT=someProjectName

To run that project in development mode:
  cd /home/vagrant/chicagoboss/someProjectName/
  ./init-dev.sh
  
Review at 'http://localhost:8881' on your host OS, the
/home/vagrant/chicagoboss directory is mounted at ../chicagoboss
on your host OS.


EOF
SCRIPT

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
  cb.vm.provision "shell", inline: $script

  # Up memory (building Erlang takes forever, feel free to reduce after
  # provisioning completes).
  cb.vm.provider :virtualbox do |vb|
    #vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    # Rename the virtualbox machine name
    vb.name = "chicagoboss"
  end
end

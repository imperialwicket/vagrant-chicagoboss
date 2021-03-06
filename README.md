Chicago Boss vagrant configuration using:
 - Chicago Boss (v0.8.11)
 - Ubuntu 12.04LTS
 - Erlang R16B02 (compiled from source)
 - Bash provisioning

## Requirements

 - [VirtualBox](https://www.virtualbox.org/wiki/Downloads) with 64bit guest system capabilities
 - [Vagrant](http://www.vagrantup.com/downloads.html)


## Quickstart

We need a local directory to mount where Chicago Boss and your applications can reside. The Vagrantfile is expecting the folder '../chicagoboss' to exist. To get your Chicago Boss environment up and running from your $HOME directory:

    cd
    mkdir chicagoboss
    git clone https://github.com/imperialwicket/vagrant-chicagoboss.git
    cd vagrant-chicagoboss
    vagrant up

Vagrant will provision your virtual machine using bash, and build Erlang (this can take a while). After completion, make your Chicago Boss project after connecting to the guest OS (`vagrant ssh`):

    cd /home/vagrant/chicagoboss/ChicagoBoss/
    make app PROJECT=someProject

Start your application from the guest OS:

    cd /home/vagrant/chicagoboss/someProject/
    ./init-dev.sh

Review your application at [http://localhost:8881](http://localhost:8881) on your host OS. The 'someProject' directory will be avialable on your host OS at $HOME/chicagoboss/someProject.


## Goals

The primary target is to make it as easy as possible to get started with Chicago Boss. It does take a while to build Erlang in a virtual machine, but generating a working vm in this way means that we also have a living bash script to get any server configured and running Chicago Boss using the same script.

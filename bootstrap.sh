#!/bin/bash

ERLANG_VERSION='R16B02'
CHICAGOBOSS_RELEASE='v0.8.11'

if [[ "$(which erl)" == "/usr/local/bin/erl" ]]; then
  echo "Erlang present, skipping installation."
else
  echo "Installing Erlang..."
  echo "(This will take several minutes)"
  apt-get update
  apt-get -y install build-essential m4 libncurses5-dev libssh-dev unixodbc-dev libgmp3-dev libwxgtk2.8-dev libglu1-mesa-dev fop xsltproc default-jdk git
  mkdir -p /usr/src/erlang
  cd /usr/src/erlang
  curl -s http://www.erlang.org/download/otp_src_${ERLANG_VERSION}.tar.gz
  tar -xvzf otp_src_${ERLANG_VERSION}.tar.gz
  cd otp_src_${ERLANG_VERSION}
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
  git checkout $CHICAGOBOSS_RELEASE
  ./rebar get-deps
  ./rebar compile
  chown -R vagrant:vagrant /home/vagrant/chicagoboss/
fi

cat << EOF
 
 
Chicago Boss (${CHICAGOBOSS_RELEASE}) installed at /home/vagrant/chicagoboss/ChicagoBoss.
Erlang version (${ERLANG_VERSION})

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

exit 0

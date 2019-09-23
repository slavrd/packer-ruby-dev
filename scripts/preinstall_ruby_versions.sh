#!/usr/bin/env bash
# Preisntall rbenv ruby versions 

# Ruby 2.3.x - need openssl 1.0.2s
## install openssl 1.0.2s
mkdir -p /tmp/src/
cd /tmp/src/
wget https://www.openssl.org/source/openssl-1.0.2s.tar.gz
tar xvzf openssl-1.0.2s.tar.gz
cd openssl-1.0.2s
mkdir -p ~/.rubies/openssl-1.0.2s
./config --prefix=${HOME}/.rubies/openssl-1.0.2s --shared
make
make install
cd ${HOME}
## install ruby 2.3.8
RUBY_CONFIGURE_OPTS=--with-openssl-dir=$HOME/.rubies/openssl-1.0.2s rbenv install 2.3.8

# Later ruby versions
for ver in "2.5.6" "2.6.4"; do
    rbenv install ${ver}
done

# preinstall bundler for all versions
for ver in "2.3.8" "2.5.6" "2.6.4"; do
    rbenv local ${ver}
    gem install bundler
    rbenv rehash
done

rm .ruby-version

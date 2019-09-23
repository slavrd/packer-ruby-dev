#!/usr/bin/env bash
# Provision the machine wiht basic needed tools

sudo apt-get update

#Define packages to install
PREREQS="make ruby ruby-build ruby-dev libssl-dev libreadline-dev zlib1g-dev rbenv"
TOOLS="curl vim git unzip" 

# Install defined packages
which $PREREQS $TOOLS || {
  sudo apt-get install -y $PREREQS $TOOLS
}

# define and install needed gems
sudo gem install rubyzip 

#update rbenv ruby-build plugin
git clone https://github.com/rbenv/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

#configure rbenv for Vagrant user
echo "" >> /home/vagrant/.bashrc
echo "#set up rbenv" >> /home/vagrant/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc

# set up git prompt
echo "" >> /home/vagrant/.bashrc
echo "# set git prompt and autocomplete" >> /home/vagrant/.bashrc
echo "source /usr/lib/git-core/git-sh-prompt" >> /home/vagrant/.bashrc

echo "" >> /home/vagrant/.profile
echo "#Set up git prompt" >> /home/vagrant/.profile
echo "export GIT_PS1_SHOWDIRTYSTATE=1" >> /home/vagrant/.profile
echo "export GIT_PS1_SHOWUNTRACKEDFILES=1" >> /home/vagrant/.profile
echo 'export PS1='\''${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[32m\]$(__git_ps1)\[\033[00m\] $ '\''' >> /home/vagrant/.profile

sudo apt-get clean

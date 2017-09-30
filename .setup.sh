#!/bin/bash
if [ ! -f /usr/local/bin/brew ]; then
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

[ -f /usr/local/bin/python2 ] || brew install python
[ -f /usr/local/bin/ansible ] || brew install ansible

ansible-playbook -i "localhost," -c local .setup-playbook.yml

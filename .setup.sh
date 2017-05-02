#!/bin/bash
if [ ! -f /usr/local/bin/brew ]; then
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install python
brew install ansible

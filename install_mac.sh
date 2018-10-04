#!/bin/bash

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
clr_red=$(tput setaf 1)
clr_reg=$(tput sgr0)

if [[ ! `uname` == 'Darwin' ]]; then
    echo "${clr_red}Could not detect a running Darwin system. Mixed up the scripts again?${clr_reg}"
    exit 1
fi

mkdir -p ~/bin
ln -sf $DIR/scripts/git-web ~/bin/
ln -sf $DIR/mac/scripts/git-web-open ~/bin/
ln -sf $DIR/mac/scripts/appify ~/bin/

echo "Making sure Homebrew is installed..."
brew --version > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing my favorite formulas..."
homebrew_pkgs="
  autoconf
  automake
  bash-git-prompt
  fzf
  git
  gnupg
  libuv
  libyaml
  mackup
  macvim
  sqlite
  telnet
  wget
"

brew install $homebrew_pkgs || brew upgrade && brew install $homebrew_pkgs

echo "Including .bash_profile"
include_string="source $DIR/mac/.bash_profile"

if ! grep "^${include_string}$" ~/.bash_profile 2>&1 > /dev/null; then
    echo "Adding the following string to ~/.bash_profile:"
    echo "  ${include_string}"
    echo $include_string >> ~/.bash_profile
fi

echo "Configure mackup..."
ln -sf $DIR/mac/.mackup.cfg ~/.mackup.cfg

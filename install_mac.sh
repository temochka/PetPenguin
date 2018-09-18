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

brew install fzf

echo "Including .bash_profile"
include_string="source $DIR/mac/.bash_profile"

if ! grep "^${include_string}$" ~/.bash_profile 2>&1 > /dev/null; then
    echo "Adding the following string to ~/.bash_profile:"
    echo "  ${include_string}"
    echo $include_string >> ~/.bash_profile
fi


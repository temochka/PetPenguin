#!/bin/sh
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
LINUX_DIR=$DIR/linux

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
ln -sf $DIR/mac/.gitconfig ~/
echo "Making sure Homebrew is installed..."
brew --version > /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing my favorite formulas..."
brew tap homebrew/cask-fonts

homebrew_pkgs="
  autoconf
  automake
  bash-completion
  bash-git-prompt
  zsh-completions
  fd
  fzf
  git
  gnupg
  jq
  libuv
  libyaml
  mackup
  macvim
  neofetch
  sqlite
  telnet
  wget
  font-fira-mono
  font-fira-code
"

brew install $homebrew_pkgs || brew upgrade && brew install $homebrew_pkgs

if [[ $SHELL == '/bin/zsh' ]]; then
    echo "Including .zprofile"
    include_string="source $DIR/mac/.zprofile"

    if ! grep "^${include_string}$" ~/.zprofile 2>&1 > /dev/null; then
        echo "Adding the following string to ~/.zprofile:"
        echo "  ${include_string}"
        echo $include_string >> ~/.zprofile
    fi
else
    echo "Including .bash_profile"
    include_string="source $DIR/mac/.bash_profile"

    if ! grep "^${include_string}$" ~/.bash_profile 2>&1 > /dev/null; then
        echo "Adding the following string to ~/.bash_profile:"
        echo "  ${include_string}"
        echo $include_string >> ~/.bash_profile
    fi
fi

echo "Configure mackup..."
ln -sf $DIR/mac/.mackup.cfg ~/.mackup.cfg

################################################################################
echo "# Configuring Vim..."
################################################################################

ln -sf $LINUX_DIR/.vimrc ~/.vimrc
mkdir -p ~/.vim ~/.vim/bundle ~/.vim/autoload
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/v2.3/autoload/pathogen.vim

cd ~/.vim/bundle

git clone https://github.com/guns/vim-clojure-static > /dev/null 2>&1
git clone https://github.com/altercation/vim-colors-solarized > /dev/null 2>&1
git clone https://github.com/tpope/vim-dispatch.git > /dev/null 2>&1
git clone https://github.com/tpope/vim-fireplace.git > /dev/null 2>&1
git clone https://github.com/tpope/vim-salve.git > /dev/null 2>&1
git clone https://github.com/tpope/vim-projectionist.git > /dev/null 2>&1


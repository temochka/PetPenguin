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


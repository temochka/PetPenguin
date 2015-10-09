#!/bin/bash

clr_red=$(tput setaf 1)
clr_reg=$(tput sgr0)

if [[ ! `uname` == 'Darwin' ]]; then
    echo "${clr_red}Could not detect a running Darwin system. Mixed up the scripts again?${clr_reg}"
    exit 1
fi

mkdir -p ~/bin
ln -sf scripts/git-web ~/bin/
ln -sf mac/scripts/git-web-open ~/bin/


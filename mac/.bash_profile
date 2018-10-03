p() {
    PROJECT=$(ls ~/projects | fzf)

    if [ -z $PROJECT ]; then
      return;
    fi

    cd ~/projects/$PROJECT
}

bind '"\C-p":"p\n"'

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    export GIT_PROMPT_THEME=Solarized
    export GIT_PROMPT_END=" ${White}${ResetColor}$ "
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi


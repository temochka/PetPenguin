p() {
    PROJECT=$(ls -a ~/projects | fzf)

    if [ -z $PROJECT ]; then
      return;
    fi

    cd ~/projects/$PROJECT
}

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line

bindkey -s "\C-p" "p\n"
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

PATH="$PATH:$HOME/bin:$HOME/.cargo/bin"
EDITOR=vim
FZF_DEFAULT_COMMAND="fd . $HOME"
FZF_CTRL_T_COMMAND="fd ."

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias gco='git checkout $(git branch | fzf)'

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

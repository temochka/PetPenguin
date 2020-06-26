p() {
    PROJECT=$(ls ~/src | fzf)

    if [ -z $PROJECT ]; then
      return;
    fi

    cd ~/src/$PROJECT
}

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line

bindkey -s "\C-p" "p\n"
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

PATH="$PATH:~/bin"
EDITOR=vim

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi


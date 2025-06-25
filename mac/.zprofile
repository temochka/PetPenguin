p() {
    PROJECT=$(ls -a ~/projects | fzf)

    if [ -z $PROJECT ]; then
      return;
    fi

    cd ~/projects/$PROJECT
}

blog-png() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: blog-png file1.png [file2.png ...]"
        return 1
    fi

    local max_width="${MAX_WIDTH:-1400}"  # Default to 1400px if MAX_WIDTH is not set

    for input_file in "$@"; do
        if [[ ! -f "$input_file" ]]; then
            echo "Skipping: $input_file (not a valid file)"
            continue
        fi

        local output_file="${input_file%.*}.compressed.png"

        echo "Processing: $input_file -> $output_file (max width: $max_width px)"

        magick "$input_file" -resize "${max_width}x" PNG:- | pngquant --quality=65-80 --speed 1 --output "$output_file" -

        echo "Compression complete: $output_file"
    done
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

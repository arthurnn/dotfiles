export PATH=/usr/local/sbin:$PATH
if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

# Custom Prompt
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export PS1='\[\e[0;31m\][\u@\h \W]\$\[\e[0m\] '
else
    export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
fi

# git
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
# git alias
alias gl='git log --date=short --pretty=format:"%C(124)%ad %C(24)%h %C(34)%an %C(252)%s%C(178)%d" --stat'
alias gsign='git commit -C HEAD -S --amend'

# terminal configs
export ALTERNATE_EDITOR=emacs EDITOR=emacs VISUAL=emacs
export TERM="xterm-256color"
alias reset-color="echo -e \"\e[39m\""

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Cask
export PATH=$PATH:$HOME/.cask/bin

# Go
export GOPATH=$HOME/src/gobox
export PATH=$PATH:$GOPATH/bin

# Python
export PATH=$PATH:$HOME/Library/Python/2.7/bin/

# chruby
if [ -n "$BASH_VERSION" ] && [ -d /usr/local/opt/chruby/share/chruby ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

if [ -n "$BASH_VERSION" ] && [ -d /usr/local/share/chruby ]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# emacs
export PATH=/usr/local/Emacs/bin:$PATH
alias e='emacsclient -t -a ""'
alias egit='e $(git ls-files -m)'

# GPG
export GPG_TTY=`tty`

# Docker
eval `boot2docker shellinit 2>/dev/null`

# Better history, things like, append the history to other tabs
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:erasedups
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

# GitHub config
if [ -d $HOME/src/github ]; then
    alias gh='cd $HOME/src/github/; pwd; chruby github; ruby -v'
fi

# from https://github.com/fxn/dotfiles/blob/c84d469981c424f1b7081914dc517bd24132d876/bashrc#L27
# Given an array GO_SHORTCUTS defined elsewhere with pairs shorcut -> directory:
#
#   GO_SHORTCUTS=(
#     rails
#     $HOME/prj/rails
#
#     tmp
#     $HOME/tmp
#  )
#
# you can cd into the destination directories given the shortcut. For example
#
#   ss rails
#
# takes you to $HOME/prj/rails from anywhere.
function ss {
    local target=$1
    local len=${#GO_SHORTCUTS[@]}
    for (( i=0; i<$len; i+=2 ));
    do
        if [[ "$1" = "${GO_SHORTCUTS[$i]}" ]]; then
            cd "${GO_SHORTCUTS[$i+1]}"
            return
        fi
    done
    echo "unknown shortcut"
}

function replace-string {
    git grep -l "$1" | xargs sed -i '' -e"s/$1/$2/g"
}

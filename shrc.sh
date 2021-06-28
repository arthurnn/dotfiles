#!/bin/sh
# shellcheck disable=SC2155

export PATH=/usr/local/sbin:$PATH
if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

# git alias
alias gl='git log --date=short --pretty=format:"%C(124)%ad %C(24)%h %C(34)%an %C(252)%s%C(178)%d" --stat'
alias gsign='git commit -C HEAD -S -s --amend'

# terminal configs
# export TERM="xterm-256color"
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

# MySQL 5.7
export MYSQLPATH=`brew --prefix mysql@5.7 2>/dev/null`
if [ -n "$MYSQLPATH" ]; then
   export PATH=$MYSQLPATH/bin:$PATH
fi

# Lets use rbenv for now
eval "$(rbenv init -)"

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# Docker
eval `boot2docker shellinit 2>/dev/null`

# GitHub config
if [ -d $HOME/src/github ]; then
    alias gh='cd $HOME/src/github/; pwd; ruby -v'
fi

# Save directory changes
cd() {
  builtin cd "$@" || return
  [ "$TERMINALAPP" ] && command -v set_terminal_app_pwd >/dev/null \
    && set_terminal_app_pwd
  pwd > "$HOME/.lastpwd"
}

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

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
export ANDROID_HOME=/usr/local/opt/android-sdk

# Cask
export PATH=$PATH:$HOME/.cask/bin

# Go
export GOPATH=$HOME/src/gobox
export PATH=$PATH:$GOPATH/bin

# chruby
if [ -n "$BASH_VERSION" ] && [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
    source /usr/local/opt/chruby/share/chruby/chruby.sh
    RUBIES+=(
        "$HOME/src/github/github/vendor/ruby/ruby-github"
    )
    source /usr/local/opt/chruby/share/chruby/auto.sh
fi

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# emacs
alias e='emacsclient -t -a ""'
alias egit='e $(git ls-files -m)'
export PATH=/usr/local/Emacs/bin:$PATH

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
alias gh='cd ~/src/github/github/; pwd; chruby 2.1.7; ruby -v'

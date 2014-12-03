export PATH=/usr/local/sbin:$PATH

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
export ALTERNATE_EDITOR=emacs EDITOR=e VISUAL=e
export TERM="xterm-256color"
alias reset-color="echo -e \"\e[39m\""

# android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Cask
export PATH=$PATH:$HOME/.cask/bin

# Go
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if [ -f ~/.rbenv/completions/rbenv.bash ]; then
  source ~/.rbenv/completions/rbenv.bash
fi

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# emacs
alias e='emacsclient -t -a ""'
alias egit='e $(git ls-files -m)'

# GPG
export GPG_TTY=`tty`

# Cuda
export PATH=$PATH:/usr/local/cuda/bin

# Shopify config
alias shopify='cd ~/src/vagrant/; vagrant ssh'
if [[ `hostname` = vagrant.myshopify.io ]]; then
    export ZOOKEEPER_ENABLED=1
    cd /home/vagrant/src/shopify
fi

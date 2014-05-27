# Custom Prompt
#export PS1="\[\033[01;32m\]\u\[\033[01;34m\]\$ \[\033[00m\]" # used to be "\h:\W \u\$ "
export PS1="\[\033[01;32m\]\u\[\033[01;34m\]{\W}\[\033[00m\]$ "

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

# Cask
export PATH=$PATH:$HOME/.cask/bin

# Go
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# rbenv
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
if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
    export GPG_AGENT_INFO
else
    eval `gpg-agent --daemon`
    echo $GPG_AGENT_INFO > $HOME/.gpg-agent-info
fi
export GPG_TTY=`tty`

# Shopify config
alias shopify='cd ~/src/vagrant/; vagrant ssh'
if [[ `hostname` = vagrant.myshopify.io ]]; then
    echo 'Welcome to Shopify...'
    export ZOOKEEPER_ENABLED=1
    export PS1="\[\033[0;31m\]\u{\W}\[\033[00m\]$ "

    cd /home/vagrant/src/shopify
fi

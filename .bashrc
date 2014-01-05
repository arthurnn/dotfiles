# git
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
# git alias
alias gl='git log --date=short --pretty=format:"%C(124)%ad %C(24)%h %C(34)%an %C(252)%s%C(178)%d" --stat'
alias egit='emacs $(git ls-files -m)'

# terminal configs
export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient
export TERM="xterm-256color"

# Go
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# Shopify config
export ZOOKEEPER_ENABLED=1

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

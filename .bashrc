
# git
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
# git alias
alias gl='git log --date=short --pretty=format:"%C(124)%ad %C(24)%h %C(34)%an %C(252)%s%C(178)%d" --stat'


export ALTERNATE_EDITOR=emacs EDITOR=emacsclient VISUAL=emacsclient

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Load Boxen env
[[ -s "/opt/boxen/env.sh" ]] && source "/opt/boxen/env.sh"

# Shopify config
export ZOOKEEPER_ENABLED=1

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

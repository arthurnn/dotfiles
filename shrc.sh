#!/bin/sh
# shellcheck disable=SC2155

# Prevent re-sourcing to avoid overriding project aliases
[ -n "$SHRC_SOURCED" ] && return
export SHRC_SOURCED=1

# Setup paths
remove_from_path() {
  [ -d "$1" ] || return
  PATHSUB=":$PATH:"
  PATHSUB=${PATHSUB//:$1:/:}
  PATHSUB=${PATHSUB#:}
  PATHSUB=${PATHSUB%:}
  export PATH="$PATHSUB"
}

add_to_path_start() {
  [ -d "$1" ] || return
  remove_from_path "$1"
  export PATH="$1:$PATH"
}

add_to_path_end() {
  [ -d "$1" ] || return
  remove_from_path "$1"
  export PATH="$PATH:$1"
}

force_add_to_path_start() {
  remove_from_path "$1"
  export PATH="$1:$PATH"
}

quiet_which() {
  command -v "$1" >/dev/null
}

add_to_path_start "/usr/local/sbin"
add_to_path_start "/home/linuxbrew/.linuxbrew/bin"
add_to_path_start "/usr/local/bin"
add_to_path_start "/opt/homebrew/bin"

add_to_path_start "$HOME/.bin"

# Ghostty terminfo fallback for remote machines without it
if [ "$TERM" = "xterm-ghostty" ] && ! infocmp xterm-ghostty >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

# aliases
alias gl='git log --date=short --pretty=format:"%C(124)%ad %C(24)%h %C(34)%an %C(252)%s%C(178)%d" --stat'
alias gsign='git commit -C HEAD -S -s --amend'
alias reset-color="echo -e \"\e[39m\""
alias tmux-main="tmux new-session -A -s main"

if [ $MACOS ]
then
  alias desktop="cd $HOME/Desktop"
fi

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

# To fix libcurl errors from ETHO gem
# See https://stackoverflow.com/questions/50168647/multiprocessing-causes-python-to-crash-and-gives-an-error-may-have-been-in-progr
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Lazy-load rbenv to speed up shell startup
if quiet_which rbenv; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  rbenv() {
    unset -f rbenv
    eval "$(command rbenv init -)"
    rbenv "$@"
  }
fi

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

# Save directory changes
cd() {
  builtin cd "$@" || return
  [ "$TERMINALAPP" ] && command -v set_terminal_app_pwd >/dev/null \
    && set_terminal_app_pwd
  pwd > "$HOME/.lastpwd"
}

# To create shortcuts:
# mkdir $HOME/ss; cd $HOME/ss
# ln -s source shortcut
ss() {
  cd "$HOME/ss/$@" &>/dev/null || echo "unknown shortcut"
}

function replace-string {
    git grep -l "$1" | xargs sed -i '' -e"s/$1/$2/g"
}

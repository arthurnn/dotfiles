# check if this is a login shell
[ "$0" = "-bash" ] && export LOGIN_BASH=1

# run bash_profile if this is not a login shell
[ -z "$LOGIN_BASH" ] && source ~/.bash_profile

# load shared shell configuration
source ~/.shrc

# History
export HISTFILE="$HOME/.bash_history"
export HISTCONTROL=ignoredups
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
export HISTIGNORE="&:ls:[bf]g:exit"

# enable direnv (if installed)
which direnv &>/dev/null && eval "$(direnv hook bash)"

# to avoid non-zero exit code
true

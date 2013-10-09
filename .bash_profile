# git
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

#android
#export SDK_ROOT=/Users/arthurnn/Library/android-sdk-macosx
#PATH=${PATH}:${SDK_ROOT}/tools
#export ANDROID_HOME=/Users/arthurnn/Library/android-sdk-macosx

# grails config
#export GRAILS_HOME=/Applications/springsource/grails-2.1.0
#PATH=${PATH}:${GRAILS_HOME}/bin

# tomcat config
#export TOMCAT_HOME=/Users/arthurnn/Library/apache-tomcat-7.0.14
#PATH=${PATH}:${TOMCAT_HOME}/bin

# git alias
alias gl='git log --date=short --pretty=format:"%C(124)%ad %C(24)%h %C(34)%an %C(252)%s%C(178)%d" --stat'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "/opt/boxen/env.sh" ]] && source "/opt/boxen/env.sh" # Load Boxen env

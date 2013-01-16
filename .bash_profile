# git
source /usr/share/git-core/git-completion.bash

#android
export SDK_ROOT=/Users/arthurnn/Library/android-sdk-macosx
PATH=${PATH}:${SDK_ROOT}/tools
export ANDROID_HOME=/Users/arthurnn/Library/android-sdk-macosx

# grails config
#export GRAILS_HOME=/Applications/springsource/grails-1.1.1
#export GRAILS_HOME=/Applications/springsource/grails-1.3.6
#export GRAILS_HOME=/Applications/springsource/grails-1.3.7
export GRAILS_HOME=/Applications/springsource/grails-2.1.0
PATH=${PATH}:${GRAILS_HOME}/bin

# tomcat config
export TOMCAT_HOME=/Users/arthurnn/Library/apache-tomcat-7.0.14
#export TOMCAT_HOME=/Users/arthurnn/Documents/java/apache-tomcat-6.0.32
#PATH=${PATH}:${TOMCAT_HOME}/bin


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

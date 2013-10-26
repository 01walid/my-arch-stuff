#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
PATH="${PATH}:/opt/vagrant/bin"
$(ruby -rubygems -e "puts Gem.user_dir")/bin

export CATALINA_HOME=/usr/share/tomcat7:/usr/share/tomcat7/lib/

export TOMCAT_HOME=/usr/share/tomcat7

export ANT_HOME=/usr/share/apache-ant/

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/itl/

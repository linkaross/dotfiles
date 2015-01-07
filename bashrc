#                                    @                     
#                 (__)    (__) _____/
#              /| (oo) _  (oo)/----/_____    *
#    _o\______/_|\_\/_/_|__\/|____|//////== *- *  * -
#   /_________   \   00 |   00 |       /== -* * -
#  [_____/^^\_____\_____|_____/^^\_____]     *- * -
#        \__/                 \__/
#
# ~/.bashrc
# todo: ps1 chroot, moar fancy git prompt
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
PS1='`if [ $? = 0 ]; then echo "\[\033[01;32m\]:) ?$?"; else echo "\[\033[01;31m\]:( ?$?"; fi`\[\e[0m\] \[\e[00;32m\]n!\! \[\e[0m\]\[\e[00;33m\]@\t \[\e[0m\]\[\e[00;37m\]` parse_git_branch `\n\[\e[0m\]\[\e[01;33m\]\u\[\e[0m\]\[\e[00;32m\]{\[\e[0m\]\[\e[00;36m\]\j\[\e[0m\]\[\e[00;32m\]}\[\e[0m\]\[\e[00;31m\]\h\[\e[0m\]\[\e[00;32m\][\[\e[0m\]\[\e[00;35m\]\w\[\e[0m\]\[\e[00;32m\]]\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]'
shopt -s histappend
shopt -s histverify
HISTCONTROL=ignoreboth
HISTSIZE=999999
unset HISTFILESIZE
PROMPT_COMMAND='history -a'
[[ -x /usr/bin/dircolors ]] && { test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)" ; } ;
unset LESSOPEN
# (v) (°,,,°) (v)
set -o vi
shopt -s checkwinsize
shopt -s autocd
shopt -s dirspell
export CDPATH='.:$HOME/.rbenv/bin:~-:..:../..:/etc:~'
alias debug="set -o nounset; set -o xtrace"
# ,,;0;,,
alias bftail="tail -F -n 1000"
alias restart_agent='eval `ssh-agent -s`'
alias ax="chmod a+x"
alias ports='sudo netstat -tulanp'
alias sockets='sudo lsof -i'
alias back="cd ~-"
alias c="clear"
alias reload="source ~/.bashrc"
alias mkdir='mkdir -p -v'
alias h='history'
alias s='ssh'
alias hmesg='dmesg -Tx'
alias nssh='ssh -q -o StrictHostKeyChecking=false -o UserKnownHostsFile=/dev/null'
alias nscp='scp -o StrictHostKeyChecking=false -o UserKnownHostsFile=/dev/null'
alias nrsync='rsync -e "ssh -o StrictHostKeyChecking=false -o UserKnownHostsFile=/dev/null"'

ff() { find . -type f -iname '*'"$*"'*' -ls ; }

fe() { find . -type f -iname '*'"${1:-}"'*' -exec ${2:-file} {} \;  ; }

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1     ;;
      *.tar.gz)    tar xvzf $1     ;;
      *.bz2)       bunzip2 $1      ;;
      *.rar)       unrar x $1      ;;
      *.gz)        gunzip $1       ;;
      *.tar)       tar xvf $1      ;;
      *.tbz2)      tar xvjf $1     ;;
      *.tgz)       tar xvzf $1     ;;
      *.zip)       unzip $1        ;;
      *.Z)         uncompress $1   ;;
      *.7z)        7z x $1         ;;
      *)           echo "'$1' error 666 cant handle archivetype" ;;
    esac
  else echo "'$1' is no file, wth" ; fi }

maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

makezip() { zip -r "${1%%/}.zip" "$1" ; }

#who cd s anyways
up() {
  if [[ -z "$1" ]]; then count=1;
   else 
     count=$1; 
   fi
  local path i
  for (( i=0; i < ${count}; i++ )); do path+=../ ; done
  cd "$path" ; }

separator() { printf "%$(tput cols)s\n"|tr ' ' '='; }

mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

whichl() { ls -l `which $1`; }

[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

eval "$(rbenv init -)"
alias g='git'
alias v='vim'
alias vag='vagrant'
#RED=`\[\033[0;31m\]`
#YELLOW=`\[\033[0;33m\]`
#GREEN=`\[\033[0;32m\]`
#BLUE=`\[\033[0;34m\]`
#LIGHT_RED=`\[\033[1;31m\]`
#LIGHT_GREEN=`\[\033[1;32m\]`
#WHITE=`\[\033[1;37m\]`
#LIGHT_GRAY=`\[\033[0;37m\]`
#COLOR_NONE=`\[\e[0m\]`
  
is_git_repository() {
 git branch > /dev/null 2>&1
}

 parse_git_branch() {
# Only display git info if we're inside a git repository.
is_git_repository || return 1
# Capture the output of the "git status" command.
git_status="$(git status 2> /dev/null)"
 
# Set color based on clean/staged/dirty.
if [[ ${git_status} =~ "working directory clean" ]]; then
  state="clean"
elif [[ ${git_status} =~ "Changes to be committed" ]]; then
  state="ready"
else
  state="dirty"
fi
# Set arrow icon based on status against remote.
remote_pattern="# Your branch is (.*) of"
if [[ ${git_status} =~ ${remote_pattern} ]]; then
  if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
    remote="ahead"
  else
    remote="sync"
  fi
fi
diverge_pattern="# Your branch and (.*) have diverged"
if [[ ${git_status} =~ ${diverge_pattern} ]]; then
  remote="diverg"
fi
# Get the name of the branch.
branch_pattern="^# On branch ([^${IFS}]*)"
if [[ ${git_status} =~ ${branch_pattern} ]]; then
  branch=${BASH_REMATCH[1]}
fi
 
# Display the prompt.
echo "(git:${state}|${branch}|${remote})"
}
 

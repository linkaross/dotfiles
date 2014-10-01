#                                    @                     
#                 (__)    (__) _____/
#              /| (oo) _  (oo)/----/_____    *
#    _o\______/_|\_\/_/_|__\/|____|//////== *- *  * -
#   /_________   \   00 |   00 |       /== -* * -
#  [_____/^^\_____\_____|_____/^^\_____]     *- * -
#        \__/                 \__/
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='`if [ $? = 0 ]; then echo "\[\033[01;32m\]:) ?$?"; else echo "\[\033[01;31m\]:( ?$?"; fi`\[\e[0m\] \[\e[00;32m\]n!\! \[\e[0m\]\[\e[00;33m\]@\t \[\e[0m\]\[\e[00;37m\]`parse_git_branch; `\n\[\e[0m\]\[\e[01;33m\]\u\[\e[0m\]\[\e[00;32m\]{\[\e[0m\]\[\e[00;36m\]\j\[\e[0m\]\[\e[00;32m\]}\[\e[0m\]\[\e[00;31m\]\h\[\e[0m\]\[\e[00;32m\][\[\e[0m\]\[\e[00;35m\]\w\[\e[0m\]\[\e[00;32m\]]\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]'

shopt -s histappend
shopt -s histreedit
shopt -s histverify


# (v) (°,,,°) (v)
set -o vi

# check the window size after each command and, if necessary,
shopt -s checkwinsize

# mimimi
shopt -s autocd
shopt -s dirspell
export CDPATH='.:~-:..:../..:/etc:~'

alias debug="set -o nounset; set -o xtrace"
#bigfoot tail.. ,,;0;,,
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

alias 9='ssh -A patrick@patrick.nine.ch'
alias 9e='ssh -A patrick@login.nine.ch'

alias nssh='ssh -q -o StrictHostKeyChecking=false -o UserKnownHostsFile=/dev/null'
alias nscp='scp -o StrictHostKeyChecking=false -o UserKnownHostsFile=/dev/null'
alias nrsync='rsync -e "ssh -o StrictHostKeyChecking=false -o UserKnownHostsFile=/dev/null"'

#file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' -exec ${2:-file} {} \;  ; }

function extract() {
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
  else
    echo "'$1' is no file, wth"
  fi
}

function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

function makezip() { zip -r "${1%%/}.zip" "$1" ; }

#who cd s anyways
up() {
  if [[ -z "$1" ]]; then 
    count=1;
  else
    count=$1;
  fi
local path i
  for (( i=0; i < ${count}; i++ )); do
    path+=../
  done
cd "$path"
}


separator() { printf "%$(tput cols)s\n"|tr ' ' '='; }

http_headers () { /usr/bin/curl -I -L $@ ; }

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

function whichl() { ls -l `which $1`; }

parse_git_branch () { git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (git::\1)#'; }


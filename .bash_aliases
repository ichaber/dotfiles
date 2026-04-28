#!/bin/bash

alias pro="cd ~/Projects && ls"

# ------- SSL
alias verifycsr='openssl req -text -noout -verify -in '

# ------- Shortcuts
alias k="kubectl "
alias kubens="kubectl ns"
alias kubectx="kubectl ctx"
alias kallpods="kubectl get pods --all-namespaces -o jsonpath=\"{.items[*].spec.containers[*].name}\" | tr -s ' ' '\n' |sort |uniq -c"
alias f="fuck "
alias fhere="find . -name "
alias ll="ls -lah "
alias lsl="ls -lahFA | less"
alias sl="ls" #typo for ls
alias stat="stat -x"
alias tailf="tail -f"
alias nvi="nvim"

# ------- Utils
alias headers="curl -svo /dev/null "
alias whereami="pwd"
alias myip="curl http://ipecho.net/plain; echo"
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"
alias mkdir="mkdir -pv"

# ------- Easier navigation: .., ..., -
alias -- -='cd -'
alias cd..="cd .."
alias ..="cd .."
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# ------- Directory listing
if [[ "$(type -p tree)" ]]; then
  alias ll='tree --dirsfirst -aLpughDFiC 1'
  alias lsd='ll -d'
else
  alias ll='ls -al'
  alias lsd='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'
fi

# ------- File size
alias df="df -ha"


# ------- Current branch or SHA if detached.
alias gbs='git branch | perl -ne '"'"'/^\* (?:\(detached from (.*)\)|(.*))/ && print "$1$2"'"'"''

#Alias for python to py3 (on Linux)
alias python=python3

# ------- View HTTP traffic
alias httpdump="sudo tcpdump -i eth0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""


# ------- Zsh config
alias zshcfg="vim ~/.zshrc"

### Functions
# ------- Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# ------- Git shortcuts (bash fallback for zsh git)
alias g='git'
function ga() { git add "${@:-.}"; } # ------- Add all files by default
alias gp='git push'
alias gpa='gp --all'
alias gpl='git pull'
alias gl='git log'
alias gg='gl --decorate --oneline --graph --date-order --all'
alias gs='git status'
alias gst='gs'
alias gd='git diff'
alias gdc='gd --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gba='git branch -a'
function gc() { git checkout "${@:-main}"; } # ------- Checkout master by default
alias gcm='gc'
alias gco='git checkout'
alias goc='gco' # ------- Dyslexia
alias gr='git remote'
alias grv='gr -v'
alias gra='git remote add'
alias grr='git remote rm'
alias gcl='git clone'
alias gcd='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'

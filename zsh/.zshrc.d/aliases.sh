#!/bin/bash

# Git shortcuts
alias ga="git add"
alias gaa="git add -A"
alias gst="git status"
alias gd="git diff"
alias gac="ga -A && gc"
alias gc="git commit"
alias gcm="git commit -m"
alias gacm="ga -A && gc -m"
alias gaca="ga -A && gc --amend"
alias gp="git push"
alias gll="git pull --all"
alias gb="git branch"
alias gcb="git checkout -b"
alias gco="git checkout"
alias glog="git log --oneline --decorate --graph"

# File and directory listing with eza
alias ls="eza --icons -T -L=1"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="eza --icons -T"

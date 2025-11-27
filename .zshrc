# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

# https://ohmyz.sh/
source $ZSH/oh-my-zsh.sh

# -------------------------------- #
# Git
# -------------------------------- #

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

function glp() {
  git --no-pager log -$1
}

# -------------------------------- #
# Directories
#
# I put
# `~/i` for my projects
# `~/f` for forks
# `~/r` for reproductions
# -------------------------------- #

function i() {
  cd ~/individuals/$1
}

function r() {
  cd ~/repros/$1
}

function f() {
  cd ~/forks/$1
}

function w() {
  cd ~/works/$1
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    gcl "$@" && cd "$(basename "$1" .git)"
  else
    gcl "$@" && cd "$2"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  repros && clone "$@" && code . && cd ~2
}

function clonef() {
  forks && clone "$@" && code . && cd ~2
}

function clonew () {
  works && clone "$@" && code . && cd ~2
}

function codei() {
  i && code "$@" && cd -
}

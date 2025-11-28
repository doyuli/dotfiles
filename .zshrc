source ~/.bash_profile

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

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
alias ghc='gh repo clone'

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
# `~/w` for works
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

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    ghc "$@" && cd "$(basename "$1" .git)"
  else
    ghc "$@" && cd "$2"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  r && clone "$@" && code . && cd ~2
}

function clonef() {
  f && clone "$@" && code . && cd ~2
}

function clonew () {
  w && clone "$@" && code . && cd ~2
}

function codei() {
  i && code "$@" && cd -
}

# -------------------------------- #
# Proxy
# -------------------------------- #

PROXY_ADDR="http://127.0.0.1:7897"

export HTTP_PROXY=$PROXY_ADDR
export HTTPS_PROXY=$PROXY_ADDR

# proxy enable
pen() {
  git config --global http.proxy "$PROXY_ADDR"
  git config --global https.proxy "$PROXY_ADDR"

  echo "Proxy enabled → $PROXY_ADDR"
}

# proxy disable
pdis() {
  git config --global --unset http.proxy
  git config --global --unset https.proxy

  echo "Proxy disabled"
}

# proxy status
psta() {
  echo "Git HTTP Proxy: $(git config --global --get http.proxy)"
  echo "Git HTTPS Proxy: $(git config --global --get https.proxy)"
}

# -------------------------------- #
# npm registry
# -------------------------------- #

alias nsta='npm config get registry'

# toggle registry
nreg() {
  local r="$(npm config get registry)"
  if [[ $r == *npmmirror* ]]; then
    r="https://registry.npmjs.org/"
  else
    r="https://registry.npmmirror.com/"
  fi
  npm config set registry "$r" && echo "npm registry → $r"
}

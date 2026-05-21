source ~/.bash_profile

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
# ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"

# Auto-load Node version via .nvmrc
zstyle ':omz:plugins:nvm' autoload yes

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  nvm
)

# https://ohmyz.sh/
source $ZSH/oh-my-zsh.sh

alias c='clear'

# -------------------------------- #
# Git
# -------------------------------- #

alias gconfig='git config --global --list'
alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'
alias release='git checkout release'
alias dev='git checkout dev'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'

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

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'
alias ghc='gh repo clone'

function glp() {
  git --no-pager log -"${1:-1}"
}

# -------------------------------- #
# Directories
# -------------------------------- #

function i() {
  cd ~/individuals/$1
}

function f() {
  cd ~/forks/$1
}

function w() {
  cd ~/workspace/$1
}

function pr() {
  if [[ -z "$1" || "$1" == "ls" ]]; then
    gh pr list
  else
    gh pr checkout "$1"
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  local target_dir
  if [[ -z "$2" ]]; then
    target_dir="$(basename "$1" .git)"
  else
    target_dir="$2"
  fi

  if [[ "$1" =~ ^(https?://|git@|ssh://) ]]; then
    gcl "$@" && cd "$target_dir"
  else
    ghc "$@" && cd "$target_dir"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function clonef() {
  f && clone "$@" && code . && cd ~2
}

function clonew () {
  w && clone "$@" && code . && cd ~2
}

# -------------------------------- #
# Proxy
# -------------------------------- #

PROXY_ADDR="http://127.0.0.1:7897"

gitproxy() {
  git config --global http.https://github.com.proxy "$PROXY_ADDR"
  git config --global https.https://github.com.proxy "$PROXY_ADDR"

  echo "Github HTTP Proxy: $(git config --global --get http.https://github.com.proxy)"
  echo "Github HTTPS Proxy: $(git config --global --get https.https://github.com.proxy)"
}

ungitproxy() {
  git config --global --unset http.https://github.com.proxy
  git config --global --unset https.https://github.com.proxy
  echo "Github Proxy Cleared"
}

# -------------------------------- #
# npm registry
# -------------------------------- #

alias nrg='npm config get registry'

# toggle registry
nrsw() {
  local r="$(npm config get registry)"
  if [[ $r == *npmmirror* ]]; then
    r="https://registry.npmjs.org/"
  else
    r="https://registry.npmmirror.com/"
  fi
  npm config set registry "$r" && echo "npm registry switched to: $r"
}

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

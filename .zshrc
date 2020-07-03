# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true

# path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# theme to load
ZSH_THEME="robbyrussell"

# path to oh-my-zsh custom folder
ZSH_CUSTOM=$HOME/.zsh

# display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(
  colored-man-pages
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# setup golang
export GOROOT="$(brew --prefix golang)/libexec"
export GOPATH="${HOME}/.go"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

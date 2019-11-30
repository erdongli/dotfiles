# path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# theme to load
ZSH_THEME="robbyrussell"

# display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(
  git
  vi-mode
)

source $ZSH/oh-my-zsh.sh

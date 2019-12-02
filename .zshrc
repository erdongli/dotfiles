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

# p10k instant prompt
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# xdg
export XDG_CONFIG_HOME XDG_CACHE_HOME
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"

# history file
HISTFILE="$XDG_STATE_HOME/zsh/history"

export SAVEHIST=10000
HISTSIZE=10000
HISTFILESIZE=20000

# history options
setopt hist_ignore_dups       # Ignore duplicate commands
setopt hist_ignore_space      # Ignore commands that start with a space
setopt append_history         # Append history instead of overwriting
setopt share_history          # Share history across sessions

# completion
autoload -U compinit; compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# p10k
source "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f "$XDG_CONFIG_HOME/powerlevel10k/p10k.zsh" ]] || source "$XDG_CONFIG_HOME/powerlevel10k/p10k.zsh"

# rust
. "$HOME/.cargo/env"

# python3
source "$XDG_STATE_HOME/python3/venv/bin/activate"

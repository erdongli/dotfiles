# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export XDG_CONFIG_HOME XDG_CACHE_HOME
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"

# Set the history file location
HISTFILE="$XDG_STATE_HOME/zsh/history"

export SAVEHIST=10000
HISTSIZE=10000
HISTFILESIZE=20000

# History options
setopt hist_ignore_dups       # Ignore duplicate commands
setopt hist_ignore_space      # Ignore commands that start with a space
setopt append_history         # Append history instead of overwriting
setopt share_history          # Share history across sessions

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Powerlevel10k
source "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f "$XDG_CONFIG_HOME/powerlevel10k/p10k.zsh" ]] || source "$XDG_CONFIG_HOME/powerlevel10k/p10k.zsh"

# Rust
. "$HOME/.cargo/env"

# Python3
source "$XDG_STATE_HOME/python3/venv/bin/activate"

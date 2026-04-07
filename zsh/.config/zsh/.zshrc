# p10k instant prompt
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history file
mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"

typeset -U PATH path fpath

HISTSIZE=10000
SAVEHIST=20000

# history options
setopt hist_ignore_dups       # ignore duplicate commands
setopt hist_ignore_space      # ignore commands that start with a space
setopt share_history          # share history across sessions

# rust
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# p10k
[[ -r "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme"
[[ -r "$XDG_CONFIG_HOME/zsh/p10k.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/p10k.zsh"

# zsh-autosuggestions
[[ -r "$XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"

# python3
mkdir -p "$XDG_STATE_HOME/python3"
export PYTHON_HISTORY="$XDG_STATE_HOME/python3/history"

# less
mkdir -p "$XDG_STATE_HOME/less"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# google cloud sdk
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  gcloud_completion="$HOMEBREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
  [[ -r "$gcloud_completion" ]] && source "$gcloud_completion"
  unset gcloud_completion
fi

# fnm
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# uv
export PATH="$HOME/.local/bin:$PATH"

# completion
mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -U compinit
compinit -i -d "$ZSH_COMPDUMP"

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %Sat %p%s

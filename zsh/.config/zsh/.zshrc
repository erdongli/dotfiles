# p10k instant prompt
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# history file
mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"

export SAVEHIST=10000
HISTSIZE=10000
HISTFILESIZE=20000

# history options
setopt hist_ignore_dups       # Ignore duplicate commands
setopt hist_ignore_space      # Ignore commands that start with a space
setopt append_history         # Append history instead of overwriting
setopt share_history          # Share history across sessions

# homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# completion
mkdir -p "$XDG_CACHE_HOME/zsh"
autoload -U compinit
compinit -i -d "$XDG_CACHE_HOME/zsh/zcompcache"

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %Sat %p%s

# p10k
[[ -r "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme"
[[ -r "$XDG_CONFIG_HOME/zsh/p10k.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/p10k.zsh"

# zsh-autosuggestions
[[ -r "$XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"

# rust
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# python3
mkdir -p "$XDG_STATE_HOME/python3"
export PYTHON_HISTORY="$XDG_STATE_HOME/python3/history"

# less
mkdir -p "$XDG_STATE_HOME/less"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# google cloud sdk
if command -v brew >/dev/null 2>&1; then
  gcloud_completion="$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  [[ -r "$gcloud_completion" ]] && source "$gcloud_completion"
  unset gcloud_completion
fi

# fnm
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# uv
export PATH="$HOME/.local/share/../bin:$PATH"

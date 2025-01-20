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
autoload -U compinit

_COMP_FILES=($XDG_CACHE_HOME/zsh/zcompcache(Nm-20))
if (( $#_COMP_FILES )); then
    compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompcache"
else
    compinit -i -d "$XDG_CACHE_HOME/zsh/zcompcache"
fi
unset _COMP_FILES

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %Sat %p%s

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# p10k
source "$XDG_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f "$XDG_CONFIG_HOME/zsh/p10k.zsh" ]] || source "$XDG_CONFIG_HOME/zsh/p10k.zsh"

# zsh-autosuggestions
source "$XDG_DATA_HOME/zsh-autosuggestions/zsh-autosuggestions.zsh"


# rust
. "$HOME/.cargo/env"

# python3
export PYTHON_HISTORY="$XDG_STATE_HOME/python3/history"
source "$XDG_STATE_HOME/python3/venv/bin/activate"

# less
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# google cloud sdk
if [ -f '/Users/erdong/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/erdong/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/erdong/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/erdong/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

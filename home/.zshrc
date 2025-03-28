export XDG_CONFIG_HOME="/Users/frank/.config"
export XDG_DATA_HOME="/Users/frank/.local/share"
export XDG_CACHE_HOME="/Users/frank/.cache"
export XDG_STATE_HOME="/Users/frank/.local/state"

source "$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
. "$HOME/.cargo/env"

export PATH="$HOME/development/flutter/bin:$XDG_DATA_HOME/go/bin:/Users/frank/.rustup/toolchains/stable-aarch64-apple-darwin/bin:$PNPM_HOME:/opt/homebrew/opt/openjdk/bin:$PATH:/Users/frank/Git/dotfiles/bin:/Users/frank/.dotnet/tools"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH:$HOME/.zfunc"

    autoload -Uz compinit
    compinit
fi

alias vi=nvim
alias vim=nvim
alias cd=z
alias lg=lazygit
alias ls=list
alias l='list -la'
alias tree='list -t'
alias timestamp='date +"%Y%m%d%H%M%S"'

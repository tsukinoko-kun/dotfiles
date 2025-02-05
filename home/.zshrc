eval "$(zoxide init zsh)"
source "$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
eval "$(starship init zsh)"
. "$HOME/.cargo/env"
eval "$(direnv hook zsh)"

export PATH="/Users/frank/.rustup/toolchains/stable-aarch64-apple-darwin/bin:$PNPM_HOME:/opt/homebrew/opt/openjdk/bin:$PATH:/Users/frank/Git/dotfiles/bin"
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
alias tree='list -la'

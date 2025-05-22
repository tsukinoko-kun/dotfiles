FPATH="$(/opt/homebrew/bin/brew --prefix)/share/zsh-completions:$(/opt/homebrew/bin/brew --prefix)/share/zsh/site-functions:$FPATH:$HOME/.zfunc"

autoload -Uz compinit
compinit
source <(jj util completion zsh)

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh

alias vi=nvim
alias vim=nvim
alias cd=z
alias lg=lazygit
alias ls=list
alias l='list -la'
alias tree='list -t'
alias timestamp='date +"%Y%m%d%H%M%S"'


FPATH="$(/opt/homebrew/bin/brew --prefix)/share/zsh-completions:$(/opt/homebrew/bin/brew --prefix)/share/zsh/site-functions:$FPATH:$HOME/.zfunc"

autoload -Uz compinit
compinit
source <(jj util completion zsh)

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
. "$HOME/.cargo/env"
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

fp() {
  local search_dirs=(
    ~/Git/personal
    ~/Git/enydyne
    ~/Git/leistenschneider
    ~/Git/bms
  )

  local selected_dir
  selected_dir=$(
    find "${search_dirs[@]}" -mindepth 1 -maxdepth 1 -type d 2> /dev/null |
      fzf
  )

  if [[ -n "$selected_dir" ]]; then
    z "$selected_dir" || return
  fi
}

yolo() {
  git add .
  # ammend if -a flag is passed
  if [[ "$1" == "-a" ]]; then
    git commit --amend --no-edit
    git push --force
  else
    git commit
    git push
  fi
}

# pnpm
export PNPM_HOME="/Users/frank/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/frank/.bun/_bun" ] && source "/Users/frank/.bun/_bun"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/frank/.lmstudio/bin"
# End of LM Studio CLI section


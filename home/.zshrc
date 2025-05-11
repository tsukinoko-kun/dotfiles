export XDG_CONFIG_HOME="/Users/frank/.config"
export XDG_DATA_HOME="/Users/frank/.local/share"
export XDG_CACHE_HOME="/Users/frank/.cache"
export XDG_STATE_HOME="/Users/frank/.local/state"
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"


export PATH="$HOME/development/flutter/bin:$XDG_DATA_HOME/go/bin:/Users/frank/.rustup/toolchains/stable-aarch64-apple-darwin/bin:$PNPM_HOME:/opt/homebrew/opt/openjdk/bin:$PATH:/Users/frank/Git/dotfiles/bin:/Users/frank/.dotnet/tools"
export VCPKG_ROOT="/Users/frank/Git/vcpkg"

source "$(/opt/homebrew/bin/brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
. "$HOME/.cargo/env"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

if type /opt/homebrew/bin/brew &>/dev/null; then
    FPATH="$(/opt/homebrew/bin/brew --prefix)/share/zsh-completions:$FPATH:$HOME/.zfunc"

    autoload -Uz compinit
    compinit
    source <(jj util completion zsh)
fi

# gcc_version=$(/opt/homebrew/bin/brew ls --versions gcc | awk '{print $2}' | sort -V | tail -n 1)
# if [ -n "$gcc_version" ]; then
#   major_version=$(echo "$gcc_version" | cut -d '.' -f 1)
#   export PATH="/opt/homebrew/Cellar/gcc/${gcc_version}/bin:$PATH"
#   alias g++="g++-$major_version"
#   alias gcc="gcc-$major_version"
#   alias c++="g++-$major_version"
#   export CXX="g++-$major_version"
#   export CC="gcc-$major_version"
# fi
export CMAKE_C_FLAGS="-Wall -Wextra"
export CMAKE_PREFIX_PATH="/opt/homebrew"

alias vi=nvim
alias vim=nvim
alias cd=z
alias lg=lazygit
alias ls=list
alias l='list -la'
alias tree='list -t'
alias timestamp='date +"%Y%m%d%H%M%S"'

valgrind() {
    if [ $# -eq 0 ]; then
        echo "Usage: valgrind <program> [arguments...]"
        return 1
    fi

    # Run leaks in the background, monitoring the next command we'll run
    leaks --atExit -- "$@" &
    leaks_pid=$!

    # Run the actual program
    "$@"

    # Wait for leaks to finish
    wait $leaks_pid
}

source $(/opt/homebrew/bin/brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(/opt/homebrew/bin/brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

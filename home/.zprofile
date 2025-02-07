export XDG_CONFIG_HOME="/Users/frank/.config"
export XDG_DATA_HOME="/Users/frank/.local/share"
export XDG_CACHE_HOME="/Users/frank/.cache"
export XDG_STATE_HOME="/Users/frank/.local/state"
export CXX="ccache /usr/bin/g++"
export CC="ccache /usr/bin/gcc"
export EDITOR="nvim"
export VISUAL="nvim"
export TEMPL_EXPERIMENT="rawgo"
export GOPATH="$XDG_DATA_HOME/go"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by Toolbox App
export PATH="$PATH:/Users/frank/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

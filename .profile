. "$HOME/.cargo/env"
. "/Users/frank/.local/share/cargo/env"

export HOMEBREW_PREFIX='/opt/homebrew'
export LD_LIBRARY_PATH="$HOMEBREW_PREFIX/opt/llvm/include"
export GPG_TTY=$(tty)
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$HOME/.local/run"
export XDG_CONFIG_HOME="$HOME/.config"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PNPM_HOME="$XDG_CONFIG_HOME/pnpm"
export GOPATH="$XDG_DATA_HOME"/go
export GOROOT="$HOMEBREW_PREFIX"/opt/go/libexec
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export COREPACK_ENABLE_STRICT=0

export LUA="$HOMEBREW_PREFIX/opt/luajit/bin/luajit"

export NVM_DIR="$XDG_CONFIG_HOME/nvm"

export GRAPHVIZ_DOT="$HOMEBREW_PREFIX/bin/dot"

export BUN_INSTALL="$HOME/.bun"

export PATH="/Users/frank/Library/Application Support/JetBrains/Toolbox/scripts:$GOPATH/bin/:$GOROOT/bin/:$PNPM_HOME:$HOME/development/flutter/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/llvm/bin/:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOME/.local/share/cargo/bin:$HOME/.local/share/nvim/mason/bin:$BUN_INSTALL/bin:$PATH"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-22.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

export RUSTC_WRAPPER=$(which sccache) 
export CC='sccache gcc'
export CXX='sccache g++'

export PATH="$XDG_DATA_HOME/bob/nvim-bin:$PATH"

export PYTHON=python3

export GEM_HOME="$XDG_DATA_HOME/gem"
export PATH="$GEM_HOME/bin:$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/ruby/lib -L$HOMEBREW_PREFIX/opt/gettext/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/ruby/include -I$HOMEBREW_PREFIX/opt/gettext/include"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/ruby/lib/pkgconfig"
export CPATH="$HOMEBREW_PREFIX/include:$(xcrun --show-sdk-path)"
export LIBRARY_PATH="$HOMEBREW_PREFIX/lib"

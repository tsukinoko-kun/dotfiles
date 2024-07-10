set -x LANG en_US.UTF-8

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
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export COREPACK_ENABLE_STRICT=0

source "$CARGO_HOME/env.fish"

export LUA="$HOMEBREW_PREFIX/opt/luajit/bin/luajit"

export NVM_DIR="$XDG_CONFIG_HOME/nvm"

export GRAPHVIZ_DOT="$HOMEBREW_PREFIX/bin/dot"

export BUN_INSTALL="$HOME/.bun"

export PATH="/Users/frank/Library/Application Support/JetBrains/Toolbox/scripts:$GOPATH/bin/:$PNPM_HOME:$HOME/development/flutter/bin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOMEBREW_PREFIX/opt/llvm/bin/:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$HOME/.local/share/cargo/bin:$HOME/.local/share/nvim/mason/bin:$BUN_INSTALL/bin:$PATH"

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

alias gcc=gcc-13
alias g++=g++-13

function mithere
    echo "Copyright $(date +%Y) Frank Mayer" > LICENSE
    echo '' >> LICENSE
    echo 'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:' >> LICENSE
    echo '' >> LICENSE
    echo 'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.' >> LICENSE
    echo '' >> LICENSE
    echo 'THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.' >> LICENSE
end

function gohere
    mkdir -p "$argv"
    cd "$argv"
    git init

    go mod init "github.com/tsukinoko-kun/$argv"
    echo 'package main' > main.go
    echo '' >> main.go
    echo 'import (' >> main.go
    echo '    "fmt"' >> main.go
    echo ')' >> main.go
    echo '' >> main.go
    echo 'func main() {' >> main.go
    echo '    fmt.Println("Hello, World!")' >> main.go
    echo '}' >> main.go

    curl https://raw.githubusercontent.com/github/gitignore/main/Go.gitignore -o .gitignore

    go mod tidy

    echo "# $argv" > README.md

    mithere
end

function csv
    column -s, -t < $argv | less -N -S
end

function branch
    # use $argv to build new branch name (replace spaces with dashes) and store in $branch
    set branch (string replace ' ' '-' "$argv")

    echo "$(git branch --show-current) -> $branch"

    # create new branch if it doesn't exist
    if not contains (git branch) $branch
        git branch $branch
    end

    # switch to new branch
    git checkout $branch

    # push branch to origin if it doesn't exist
    if not contains (git branch -r) origin/$branch
        git push --set-upstream origin $branch
    else
        git pull
    end
end

export VISUAL=$(which zed)
export EDITOR=$(which nvim)
export GIT_EDITOR=$(which nvim)

function _git_branch_name
    set -l git_dir
    if test -d .git
        set git_dir .git
    else
        set git_dir (git rev-parse --git-dir 2>/dev/null)
    end
    test -n "$git_dir"; or return

    set -l r ''
    set -l b
    if test -f $git_dir/rebase-merge/interactive
        set r ' REBASE-i'
        set b (cat $git_dir/rebase-merge/head-name)
    else; if test -d $git_dir/rebase-merge
        set r ' REBASE-m'
        set b (cat $git_dir/rebase-merge/head-name)
        else
            if test -d $git_dir/rebase-apply
                if test -f $git_dir/rebase-apply/rebasing
                    set r ' REBASE'
                else; if test -f $git_dir/rebase-apply/applying
                        set r ' AM'
                    else
                        set r ' AM/REBASE'
                    end
                end
            else; if test -f $git_dir/MERGE_HEAD
                    set r ' MERGING'
                else; if test -f $git_dir/CHERRY_PICK_HEAD
                        set r ' CHERRY-PICKING'
                    else; if test -f $git_dir/BISECT_LOG
                            set r ' BISECTING'
                        end
                    end
                end
            end

            set b (git symbolic-ref --short HEAD)
        end
    end

    set b (string replace -r '^remotes/origin/' '' $b)
    set b (string replace -r '^remotes/' '' $b)

    echo -n "$r $b"
end

function fish_prompt
    echo (set_color brblack) (prompt_pwd) (set_color brblack) (_git_branch_name)
    echo -n (set_color brblack) '❯ '
end
# Async prompt setup.
set async_prompt_functions _git_branch_name
function _git_branch_name_loading_indicator
    echo -n (set_color brblack) '…'
end

function neofetch
    echo -n $fish_greeting
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    alias lg='lazygit'
    zoxide init fish | source
    golangci-lint completion fish | source
    yab completion fish | source
    gut completion fish | source
    complete -f -c dotnet -a "(dotnet complete (commandline -cp))"

    alias cd='z'
    alias ls='list'
    alias l='list -la'
    alias tree='list -t'
    alias grep='rg'
    alias du='dust'
    alias copy='pbcopy'
    alias paste='pbpaste'
    alias gtree='git log --oneline --graph --color --all --decorate'
    alias vim='nvim'
    alias vi='nvim'
    alias py='python3'
    alias python='python3'
    alias pip='uv pip'
    alias venv='uv venv'
    alias lua='luajit'

    set -l c0 "$(set_color white)"
    set -l c1 "$(set_color green)"
    set -l c2 "$(set_color yellow)"
    set -l c3 "$(set_color red)"
    set -l c4 "$(set_color purple)"
    set -l c5 "$(set_color blue)"

    set -g fish_greeting "
$c1                     'c.         $(whoami)$c0@$(set_color green)Franks-MBP
$c1                  ,xNMM.        $c0 ---------------------------------
$c1                .OMMMMo         $c2 OS$c0: macOS
$c1                lMM'            $c2 Interactive Shell$c0: fish
$c1      .;loddo:.  .olloddol;.    $c2 Default Shell$c0: $(basename $SHELL)
$c1    cKMMMMMMMMMMNWMMMMMMMMMM0:  $c2 Packages$c0: $(math $(list -c $HOMEBREW_PREFIX/bin) + $(list -c $HOMEBREW_PREFIX/Caskroom/)) (homebrew), $(list -c $GOPATH/bin/) (go), $(list -c $CARGO_HOME/bin/) (cargo), $(list -c $PNPM_HOME/) (pnpm)
$c2  .KMMMMMMMMMMMMMMMMMMMMMMMWd.  $c2 DE$c0: Aqua
$c2  XMMMMMMMMMMMMMMMMMMMMMMMX.    $c2 WM$c0: Quartz Compositor
$c3 ;MMMMMMMMMMMMMMMMMMMMMMMM:     $c2 Terminal$c0: $TERM_PROGRAM $TERM
$c3 :MMMMMMMMMMMMMMMMMMMMMMMM:     $c2 Terminal Font$c0: JetBrains Mono 
$c3 .MMMMMMMMMMMMMMMMMMMMMMMMX.    $c2 CPU$c0: $(sysctl -n machdep.cpu.brand_string) $(sysctl -n hw.logicalcpu_max)-Core
$c3  kMMMMMMMMMMMMMMMMMMMMMMMMWd.
$c4  'XMMMMMMMMMMMMMMMMMMMMMMMMMMk
$c4   'XMMMMMMMMMMMMMMMMMMMMMMMMK.
$c5     kMMMMMMMMMMMMMMMMMMMMMMd
$c5      ;KMMMMMMMWXXWMMMMMMMk.
$c5        'cooc*'    '*coo''
"
else
    set -g async_prompt_enable 0
    set -g fish_greeting ''
end

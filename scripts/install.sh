#!/bin/sh
xcode-select --install
softwareupdate --install-rosetta
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew bundle install --file=./Brewfile
chmod go-w '/opt/homebrew/share'
chmod -R go-w '/opt/homebrew/share/zsh'
stow . -t ~
if [ -f "$HOME/.zshenv" ]; then
    source "$HOME/.zshenv"
fi
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

# .NET
sudo mkdir -p /usr/local/share/dotnet
sudo ln -s /opt/homebrew/opt/dotnet/libexec /usr/local/share/dotnet

# Go
/opt/homebrew/bin/go install github.com/air-verse/air@latest
/opt/homebrew/bin/go install github.com/a-h/templ/cmd/templ@latest
/opt/homebrew/bin/go install github.com/spf13/cobra-cli@latest

# Pinentry
if [ ! -e "$HOME/.gnupg/gpg-agent.conf" ]; then
    echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > "$HOME/.gnupg/gpg-agent.conf"
    gpgconf --kill gpg-agent
    gpgconf --launch gpg-agent
fi

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
mkdir ~/.zfunc
~/.cargo/bin/rustup completions zsh cargo > ~/.zfunc/_cargo

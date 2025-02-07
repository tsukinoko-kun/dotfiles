#!/bin/sh
xcode-select --install
softwareupdate --install-rosetta
ditto --force ./home/ ~/
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi
if [ -f "$HOME/.zshenv" ]; then
    source "$HOME/.zshenv"
fi
/opt/homebrew/bin/brew bundle install --file=./Brewfile
chmod go-w '/opt/homebrew/share'
chmod -R go-w '/opt/homebrew/share/zsh'
./install_dotnet.sh
./install_go.sh
./install_pinentry.sh
./install_rust.sh

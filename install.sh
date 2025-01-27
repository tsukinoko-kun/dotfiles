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
/opt/homebrew/bin/brew bundle install --file=./Brewfile
./install_dotnet.sh

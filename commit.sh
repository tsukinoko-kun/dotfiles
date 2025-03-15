#!/bin/sh

touch .configignore

brew bundle dump --force --file=./Brewfile
git add ./Brewfile

mkdir -p ./home/.config/
rsync -av --exclude-from=./.configignore ~/.config/ ./home/.config/

if [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" ./home/.zshrc
else
    rm ./home/.zshrc || true
fi

if [ -f "$HOME/.zprofile" ]; then
    cp "$HOME/.zprofile" ./home/.zprofile
else
    rm ./home/.zprofile || true
fi

if [ -f "$HOME/.zshenv" ]; then
    cp "$HOME/.zshenv" ./home/.zshenv
else
    rm ./home/.zshenv || true
fi

if [ -f "$HOME/.ideavimrc" ]; then
    cp "$HOME/.ideavimrc" ./home/.ideavimrc
else
    rm ./home/.ideavimrc || true
fi

if [ -f "$HOME/.gitconfig" ]; then
    cp "$HOME/.gitconfig" ./home/.gitconfig
else
    rm ./home/.gitconfig || true
fi

if [ -f "$HOME/.gitignore" ]; then
    cp "$HOME/.gitignore" ./home/.gitignore
else
    rm ./home/.gitignore || true
fi

git add ./home/

git commit -m "dotfiles auto commit at $(date)"

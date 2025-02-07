#!/bin/sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
mkdir ~/.zfunc
~/.cargo/bin/rustup completions zsh cargo > ~/.zfunc/_cargo

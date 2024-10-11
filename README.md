# dotfiles

Neovim config: [tsukinoko-kun/nvim](https://github.com/tsukinoko-kun/nvim)

## Nix

```shell
sh <(curl -L https://nixos.org/nix/install)
nix-shell -p git --run 'git clone https://github.com/tsukinoko-kun/dotfiles.git ~/Git/dotfiles'
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/Git/dotfiles/nix#macbook
```

### GPG Sign

https://gist.github.com/troyfontaine/18c9146295168ee9ca2b30c00bd1b41e


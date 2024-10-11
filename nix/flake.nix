{
  description = "development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.audacity
        pkgs.neovim
        pkgs.mkalias
        pkgs.wezterm
        pkgs.openssl_3_2
        pkgs.raycast
        pkgs.discord
        pkgs.coreutils
        pkgs.cppcheck
        pkgs.ffmpeg_7-full
        pkgs.fzf
        pkgs.gh
        pkgs.git
        pkgs.git-lfs
        pkgs.gnupg
        pkgs.go
        pkgs.pkg-config
        pkgs.golangci-lint
        pkgs.golines
        pkgs.graphviz
        pkgs.gum
        pkgs.imagemagick
        pkgs.jq
        pkgs.just
        pkgs.lazygit
        pkgs.markdownlint-cli
        pkgs.pinentry_mac
        pkgs.plantuml
        pkgs.pnpm
        pkgs.protobuf
        pkgs.ripgrep
        pkgs.rustup
        pkgs.sccache
        pkgs.shellcheck
        pkgs.skimpdf
        pkgs.stylua
        pkgs.tmux
        pkgs.typst
        pkgs.viu
        pkgs.wget
        pkgs.yamllint
        pkgs.rustywind
        pkgs.goimports-reviser
        pkgs.xz
      ];

      homebrew = {
        enable = true;
        casks = [
          "beekeeper-studio"
          "corretto"
          "hot"
          "orbstack"
        ];
        brews = [
          "tidy-html5"
        ];
        masApps = {
          "DaVinci Resolve" = 571213070;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbook
    darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "frank";
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook".pkgs;
  };
}


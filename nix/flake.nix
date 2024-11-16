{
  description = "development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # home-nix = { url = "path:./home.nix"; flake = false; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.air
            pkgs.aldente
            pkgs.audacity
            pkgs.carapace
            pkgs.checkstyle
            pkgs.cmake
            pkgs.cppcheck
            pkgs.duti
            pkgs.neovim
            pkgs.nodejs_20
            pkgs.nodePackages_latest.jsonlint
            pkgs.mkalias
            pkgs.openssl_3_3
            pkgs.raycast
            pkgs.ccls
            pkgs.coreutils
            pkgs.cppcheck
            pkgs.ffmpeg_7-full
            pkgs.fzf
            pkgs.gh
            pkgs.git
            pkgs.git-lfs
            pkgs.gnupg
            pkgs.go
            pkgs.google-java-format
            pkgs.pkg-config
            pkgs.golangci-lint
            pkgs.golines
            pkgs.graphviz
            pkgs.gum
            pkgs.imagemagick
            pkgs.jetbrains-mono
            pkgs.jq
            pkgs.just
            pkgs.lame
            pkgs.lazygit
            pkgs.luajitPackages.luacheck
            pkgs.markdownlint-cli
            pkgs.nixfmt-rfc-style
            pkgs.pinentry_mac
            pkgs.plantuml
            pkgs.pnpm
            pkgs.protobuf
            pkgs.recode
            pkgs.revive
            pkgs.ripgrep
            pkgs.rustup
            pkgs.sccache
            pkgs.shellcheck
            pkgs.skimpdf
            pkgs.sshpass
            pkgs.starship
            pkgs.stylelint
            pkgs.stylua
            pkgs.templ
            pkgs.tmux
            pkgs.typst
            pkgs.typstyle
            pkgs.typst-lsp
            pkgs.viu
            pkgs.wget
            pkgs.yamllint
            pkgs.rustywind
            pkgs.goimports-reviser
            pkgs.xz
            pkgs.yaml-language-server
            pkgs.zoxide
          ];

          homebrew = {
            enable = true;
            taps = [
              {
                name = "tsukinoko-kun/tap";
                clone_target = "https://github.com/tsukinoko-kun/homebrew-tap.git";
                force_auto_update = true;
              }
              "teamookla/speedtest"
            ];
            casks = [
              "arc"
              "bartender"
              "beekeeper-studio"
              "corretto"
              "discord"
              "hot"
              "orbstack"
              "spotify"
              "sublime-text"
              "termius"
              "vlc"
              "wezterm"
              "zen-browser"
            ];
            brews = [
              "speedtest"
              "tidy-html5"
              "tsukinoko-kun/tap/portal"
              "tsukinoko-kun/tap/serve"
              "tsukinoko-kun/tap/zzh"
              "uv"
            ];
            masApps = {
              "DaVinci Resolve" = 571213070;
              "Ausweis App" = 948660805;
              "Bitwarden" = 1352778147;
              "Evertag" = 1594027661;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          fonts.packages = [
            (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
          ];

          system.activationScripts.applications.text =
            let
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

          security.pam.enableSudoTouchIdAuth = true;

          programs.zsh = {
            enable = true;
            promptInit = "";
          };

          users.users.frank.home = "/Users/frank";

          system.defaults = {
            dock = {
              autohide = true;
              mru-spaces = false;
              persistent-apps = [
                "/Applications/Arc.app"
                "/Applications/WezTerm.app"
                "/Applications/Discord.app"
                "/Applications/Spotify.app"
              ];
              magnification = true;
              largesize = 64;
              tilesize = 48;
              orientation = "bottom";
              wvous-bl-corner = 1;
              wvous-br-corner = 1;
              wvous-tl-corner = 1;
              wvous-tr-corner = 1;
            };
            screencapture = {
              disable-shadow = true;
              location = "/Users/frank/Desktop";
              show-thumbnail = true;
              type = "jpg";
            };
            menuExtraClock = {
              ShowAMPM = false;
              ShowDayOfWeek = true;
              ShowDate = 0;
              ShowSeconds = false;
            };
            WindowManager = {
              EnableStandardClickToShowDesktop = false;
            };
            finder.FXPreferredViewStyle = "icnv";
            finder.ShowPathbar = true;
            finder.AppleShowAllExtensions = true;
            loginwindow.GuestEnabled = false;
            NSGlobalDomain = {
              AppleICUForce24HourTime = true;
              AppleInterfaceStyle = "Dark";
              AppleMetricUnits = 1;
              ApplePressAndHoldEnabled = true;
              AppleShowAllExtensions = true;
              AppleTemperatureUnit = "Celsius";
              KeyRepeat = 2;
              NSAutomaticCapitalizationEnabled = false;
              NSAutomaticDashSubstitutionEnabled = false;
              NSAutomaticPeriodSubstitutionEnabled = false;
              NSAutomaticQuoteSubstitutionEnabled = false;
              NSAutomaticSpellingCorrectionEnabled = false;
              _HIHideMenuBar = false;
            };
            screensaver.askForPasswordDelay = 10;
          };

          networking.hostName = "franks-macbook-pro";
          networking.computerName = "Frank’s MacBook Pro";
          networking.localHostName = "franks-macbook-pro";

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

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
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "frank";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.frank = import /Users/frank/Git/dotfiles/nix/home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macbook".pkgs;
    };
}

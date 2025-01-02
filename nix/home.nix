{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "frank";
  home.homeDirectory = "/Users/frank";
  home.stateVersion = "24.05";
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/Users/frank/Library/Application Support/JetBrains/Toolbox/scripts"
    "/Users/frank/go/bin"
    "/Users/frank/.cargo/bin"
  ];
  home.shellAliases = {
    "vi" = "nvim";
    "vim" = "nvim";
    "cd" = "z";
    "lg" = "lazygit";
    "hms" = "darwin-rebuild switch --flake .#macbook --impure";
    "ls" = "list";
    "l" = "list -la";
    "tree" = "list -t";
    "top" = "sudo mactop";
  };
  home.sessionVariables = {
    "CXX" = "ccache /usr/bin/g++";
    "CC" = "ccache /usr/bin/gcc";
    "EDITOR" = "nvim";
    "VISUAL" = "nvim";
    "TEMPL_EXPERIMENT" = "rawgo";
    "GOPATH" = "/Users/frank/go";
    "XDG_CONFIG_HOME" = "/Users/frank/.config";
    "XDG_DATA_HOME" = "/Users/frank/.local/share";
    "XDG_CACHE_HOME" = "/Users/frank/.cache";
    "XDG_STATE_HOME" = "/Users/frank/.local/state";
  };
  home.activation = {
    setDefaultHandler = lib.hm.dag.entryAfter [ "desktop-startup" ] ''
        /usr/bin/defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{ LSHandlerContentType = "public.text"; LSHandlerPreferredVersions = { LSHandlerRoleAll = "-"; }; LSHandlerRoleAll = "dev.zed.Zed"; }'
        /usr/bin/defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{ LSHandlerContentType = "public.svg-image"; LSHandlerPreferredVersions = { LSHandlerRoleAll = "-"; }; LSHandlerRoleAll = "com.seriflabs.affinitydesigner2"; }'

      # Reset Launch Services to apply changes immediately
      /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
        -kill -r -domain local -domain user -domain system
    '';
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry_mac;
  };

  home.file."${config.home.sessionVariables.XDG_CONFIG_HOME}/ghostty/config" = {
    text = ''
      font-family = "JetBrains Mono"
      font-size = 17
      window-height = 1000000
      window-width = 1000000
      window-save-state = always
      mouse-hide-while-typing = true
      window-inherit-font-size = true
      theme = catppuccin-mocha
      window-vsync = true
      window-padding-color = extend
      window-colorspace = display-p3
      copy-on-select = false
      shell-integration = zsh
      macos-auto-secure-input = true
      macos-titlebar-style = tabs
      keybind = super+l=goto_split:right
      keybind = super+h=goto_split:left
      keybind = super+j=goto_split:bottom
      keybind = super+k=goto_split:top
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-fzf-history-search";
        src = pkgs.zsh-fzf-history-search;
        file = "share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh";
      }
      {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
    ];
  };

  programs.carapace = {
    enable = true;
    package = pkgs.carapace;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        truncation_symbol = "…/";
      };
      format = "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_contex$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$shell$character";
      right_format = "$all";
      aws = {
        symbol = "  ";
      };
      buf = {
        symbol = " ";
      };
      c = {
        symbol = " ";
      };
      conda = {
        symbol = " ";
      };
      crystal = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
      };
      directory = {
        read_only = " 󰌾";
      };
      docker_context = {
        symbol = " ";
      };
      elixir = {
        symbol = " ";
      };
      elm = {
        symbol = " ";
      };
      fennel = {
        symbol = " ";
      };
      fossil_branch = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
      };
      golang = {
        symbol = " ";
      };
      guix_shell = {
        symbol = " ";
      };
      haskell = {
        symbol = " ";
      };
      haxe = {
        symbol = " ";
      };
      hg_branch = {
        symbol = " ";
      };
      hostname = {
        ssh_symbol = " ";
      };
      java = {
        symbol = " ";
      };
      julia = {
        symbol = " ";
      };
      kotlin = {
        symbol = " ";
      };
      lua = {
        symbol = " ";
      };
      memory_usage = {
        symbol = "󰍛 ";
      };
      meson = {
        symbol = "󰔷 ";
      };
      nim = {
        symbol = "󰆥 ";
      };
      nix_shell = {
        symbol = " ";
      };
      nodejs = {
        symbol = " ";
      };
      ocaml = {
        symbol = " ";
      };
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        RockyLinux = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
      };
      package = {
        symbol = "󰏗 ";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      pijul_channel = {
        symbol = " ";
      };
      python = {
        symbol = " ";
      };
      rlang = {
        symbol = "󰟔 ";
      };
      ruby = {
        symbol = " ";
      };
      rust = {
        symbol = "󱘗 ";
      };
      scala = {
        symbol = " ";
      };
      swift = {
        symbol = " ";
      };
      zig = {
        symbol = " ";
      };
    };
  };

  programs.go = {
    enable = true;
    package = pkgs.go;
    goPath = "go";
  };
}

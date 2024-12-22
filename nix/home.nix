{ config, pkgs, ... }:

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

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry_mac;
  };

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local mux = wezterm.mux

      local function get_appearance_mode()
        -- Run osascript to get the appearance
        local handle =
          io.popen("osascript -e 'tell application \"System Events\" to tell appearance preferences to return dark mode'")
        if not handle then
          return "error"
        end
        local result = handle:read("*a")
        handle:close()

        -- Trim result and convert to boolean
        result = result:match("^%s*(.-)%s*$")
        return result == "true" and "dark" or "light"
      end

      wezterm.on("gui-startup", function(cmd)
        local _, _, window = mux.spawn_window(cmd or {})
        window:gui_window():maximize()
      end)

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = get_appearance_mode() == "dark" and "Catppuccin Mocha" or "Catppuccin Latte"
      config.default_cursor_style = "SteadyBar"

      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }

      config.send_composed_key_when_left_alt_is_pressed = false
      config.send_composed_key_when_right_alt_is_pressed = false

      config.window_decorations = "RESIZE"
      -- config.font = wezterm.font("JetBrains Mono")
      config.font = wezterm.font_with_fallback({
        "JetBrains Mono",
        "JetBrainsMono Nerd Font",
        "Apple Color Emoji",
        "Courier New",
      })
      config.font_size = 17.0
      config.unicode_version = 16
      config.leader = { key = "b", mods = "CTRL" }
      config.hide_tab_bar_if_only_one_tab = false
      config.tab_bar_at_bottom = true
      config.use_fancy_tab_bar = false

      config.keys = {
        { key = "5", mods = "ALT", action = wezterm.action({ SendString = "[" }) },
        { key = "6", mods = "ALT", action = wezterm.action({ SendString = "]" }) },
        { key = "7", mods = "ALT", action = wezterm.action({ SendString = "|" }) },
        { key = "8", mods = "ALT", action = wezterm.action({ SendString = "{" }) },
        { key = "9", mods = "ALT", action = wezterm.action({ SendString = "}" }) },
        { key = "/", mods = "SHIFT|ALT", action = wezterm.action({ SendString = "\\" }) },
        { key = "n", mods = "ALT", action = wezterm.action({ SendString = "~" }) },
        { key = "l", mods = "ALT", action = wezterm.action({ SendString = "@" }) },
        { key = "^", action = wezterm.action({ SendString = "^" }) },
        { key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
        {
          key = "-",
          mods = "LEADER",
          action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
        },
        {
          key = "\\",
          mods = "LEADER",
          action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
        },
        {
          key = "s",
          mods = "LEADER",
          action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
        },
        {
          key = "v",
          mods = "LEADER",
          action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
        },
        { key = "o", mods = "LEADER", action = "TogglePaneZoomState" },
        { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
        { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
        { key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
        { key = "LeftArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
        { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
        { key = "DownArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
        { key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
        { key = "UpArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
        { key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
        { key = "RightArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
        { key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
        { key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
        { key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
        { key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
        { key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
        { key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
        { key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
        { key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
        { key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
        { key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
        { key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
        { key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
        { key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
        { key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
        { key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
        { key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
        { key = '"', mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
        { key = "%", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
      }

      return config
    '';
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

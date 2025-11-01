fish_vi_key_bindings
set -U fish_greeting
bind -M insert alt-b prevd-or-backward-word repaint
bind -M insert alt-f nextd-or-forward-word repaint
bind -M insert super-f fp repaint
bind -M normal super-f fp repaint

function fish_mode_prompt
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color --bold -b blue ; set_color black
                echo ' N '
            case insert
                set_color --bold -b green ; set_color black
                echo ' I '
            case replace_one
                set_color --bold -b red ; set_color black
                echo ' r '
            case replace
                set_color --bold -b red ; set_color black
                echo ' R '
            case visual
                set_color --bold -b magenta ; set_color black
                echo ' V '
        end
        set_color normal
        echo -n ' '
    end
end

function fish_jj_prompt --description 'Print jj status'
    if not command -sq jj
        return 1
    end
    if not jj root --quiet > /dev/null 2> /dev/null
        return 1
    end
    and jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template '
      " " ++
      separate(" ",
        "🥋",
        change_id.shortest(4),
        bookmarks,
        "|",
        concat(
          if(conflict, "💥"),
          if(divergent, "🚧"),
          if(hidden, "👻"),
          if(immutable, "🔒"),
        ),
        raw_escape_sequence("\x1b[1;32m") ++ if(empty, "(empty)"),
        raw_escape_sequence("\x1b[1;32m") ++ coalesce(
          truncate_end(29, description.first_line(), "…"),
          "(no description set)",
        ) ++ raw_escape_sequence("\x1b[0m"),
      )
    '
end

function fish_vcs_prompt --description 'Print all vcs prompts'
    pogo info $argv
    or fish_jj_prompt $argv
    or fish_git_prompt $argv
    or fish_hg_prompt $argv
    or fish_fossil_prompt $argv
end

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end

abbr -a vi nvim
abbr -a vim nvim
abbr -a lg lazygit
abbr -a l ls -la
abbr -a oc opencode .
alias cd z

set -gx XDG_CONFIG_HOME "/Users/frank/.config"
set -gx XDG_DATA_HOME "/Users/frank/.local/share"
set -gx XDG_CACHE_HOME "/Users/frank/.cache"
set -gx XDG_STATE_HOME "/Users/frank/.local/state"
set -gx BUN_INSTALL_CACHE_DIR "$XDG_CACHE_HOME/bun"

set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx DOTNET_ROOT "/opt/homebrew/opt/dotnet/libexec"
set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx VCPKG_ROOT "/Users/frank/Git/vcpkg"
set -gx CMAKE_C_FLAGS "-Wall -Wextra"
set -gx CMAKE_PREFIX_PATH "/opt/homebrew"
set -gx EDITOR "/opt/homebrew/bin/nvim"
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
set -gx COMPOSE_BAKE "true"
set -gx GOBIN "$HOME/go/bin"
set -gx GOPATH "$HOME/go"

set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/readline/lib/pkgconfig:/opt/homebrew/opt/curl/lib/pkgconfig"

function setcursors
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_visual underscore
end

set -gx LANG en_US.UTF-8

fish_add_path "/Users/frank/Library/pnpm"
fish_add_path "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
fish_add_path "$HOME/.dotnet/tools"
fish_add_path "/opt/homebrew/opt/coreutils/libexec/gnubin"
fish_add_path "/opt/homebrew/opt/openjdk/bin"
fish_add_path "$PNPM_HOME/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "/opt/homebrew/bin/"
fish_add_path "/Users/frank/.rustup/toolchains/stable-aarch64-apple-darwin/bin"
fish_add_path "/Users/frank/.cargo/bin"
fish_add_path "/opt/homebrew/opt/ccache/libexec"
fish_add_path "/opt/homebrew/opt/llvm/bin"
fish_add_path "/opt/homebrew/opt/curl/bin"

zoxide init fish | source
fzf --fish | source
jj util completion fish | source
pijul completion fish | source
pogo completion fish | source

# Catppuccin Mocha Theme for FZF
set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#313244,label:#CDD6F4"

function fp
    set -l search_dirs \
        "$HOME/Git/personal" \
        "$HOME/Git/enydyne" \
        "$HOME/Git/leistenschneider" \
        "$HOME/Git/bms"

    set -l selected_dir
    set selected_dir (find $search_dirs -mindepth 1 -maxdepth 1 -type d 2> /dev/null | fzf)

    if test -n "$selected_dir" # Check if selected_dir is not empty
        z "$selected_dir" # Call the 'z' function from zoxide
        or return 1
    end
end

function yolo
    git add -A
    if test "$argv[1]" = "-a"
        git commit --amend --no-edit
        git push --force-with-lease
    else
        git commit
        git push
    end
end

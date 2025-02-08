{pkgs, ...}: {
  # imports = [./modules/latex];
  programs.zed-editor = {
    enable = true;
    # TODO: Move this to respective programming-lang-templates in my model flake.
    extraPackages = with pkgs; [
      nixd
      haskell-language-server
      nodePackages_latest.purescript-language-server
    ];
    extensions = ["haskell" "html" "latex" "nix" "purescript" "uiua"];
    userSettings = {
      # Zed settings
      autosave = "on_focus_change";
      restore_on_startup = "none";
      base_keymap = "SublimeText";
      buffer_font_family = "JetBrains Mono NL";
      buffer_font_fallbacks = ["JuliaMono" "D2Coding"];
      buffer_font_size = 12;
      buffer_font_weight = 400;
      buffer_line_height = {"custom" = 1.64;};
      confirm_quit = true;
      centered_layout = {
        left_padding = 0.8;
        right_padding = 0.8;
      };
      load_direnv = "shell_hook";
      current_line_highlight = "all";
      cursor_blink = false;
      scrollbar = {show = "never";};

      toolbar = {
        breadcrumbs = true;
        quick_actions = false;
      };

      enable_language_server = true;
      format_on_save = "on";
      use_autoclose = false;

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };

      languages = {
        "Nix" = {
          language_servers = ["nixd"];
          format_on_save = {
            external = {
              command = "alejandra";
              arguments = ["--quiet"];
            };
          };
        };
      };

      indent_guides = {
        enabled = false;
      };

      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
        show_background = false;
        edit_debounce_ms = 700;
        scroll_debounce_ms = 50;
      };

      soft-wrap = "editor_width";

      collaboration_panel = {
        button = false;
      };
      chat_panel = {
        button = false;
      };
      notification_panel = {
        button = false;
      };
      assistant = {
        button = false;
        enabled = false;
      };
      terminal = {
        button = false;
      };
      features = {
        inline_completion_provider = "none";
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };

      project_panel = {
        button = true;
        # default_width =;
        dock = "right";
        entry_spacing = "comfortable";
        file_icons = true;
        folder_icons = true;
        git_status = true;
        indent_size = 16;
        indent_guides = {enabled = false;};
        auto_reveal_entries = true;
        auto_fold_dirs = true;
        scrollbar = {
          show = null;
        };
      };

      vim_mode = true;
      ui_font_family = "Manrope";
      ui_font_size = 14;
      ui_font_weight = 600;
      theme = {
        mode = "system";
        light = "One Dark";
        dark = "One Dark";
      };
    };
  };
}

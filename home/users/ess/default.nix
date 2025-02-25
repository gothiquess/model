{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./apps
    ./impermanence
    ./scripts
    # TODO: Setup secrets with sops + homeManager templates
    # NOTE: DO I really need this?
    # ./secrets/sops
  ];

  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      # misc
      speechd
      android-tools
      qpwgraph
      # vcs
      hut
      # nix
      nix-output-monitor
      alejandra
      cachix
      # inputs
      inputs.ags.packages.${system}.io
      inputs.ags.packages.${system}.notifd
      inputs.nixgl
      # docs
      foliate
    ];

    sessionPath = [];
    sessionVariables = {
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GIT_SSH_COMMAND = "ssh -o IdentitiesOnly=yes -i $HOME/.ssh/id_ed25519";
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/data/dc";
      download = "${config.home.homeDirectory}/data/dw";
    };
  };

  programs = {
    home-manager.enable = true;

    ssh = {
      enable = true;

      matchBlocks = {
        "main" = {
          host = "gitlab.com github.com";
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_ed25519.pub"
          ];
        };
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;
      historyControl = ["ignoredups"];
      bashrcExtra = ''

        # Bash env.
        XDG_CONFIG_HOME="$HOME/.config";
        XDG_STATE_HOME="$HOME/.local/state";
        XDG_CACHE_HOME="$HOME/.cache";
        XDG_DATA_HOME="$HOME/.local/share";

        # Prompt
        PS1="$ " '';

      shellAliases = {
        l = "ls -AFhlv --group-directories-first";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        rm = "rm -i";
      };
    };

    git = {
      enable = true;
      extraConfig = {
        user.name = "gothiquess";
        user.email = "goldengoth.mail@gmail.com";
        init.defaultBranch = "main";
      };
    };
  };
}

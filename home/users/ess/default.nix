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
    # ./secrets/sops
  ];

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      curl
      wget
      perl
      rlwrap
      tree
      gnutar
      unzip
      p7zip
      ripgrep
      ripgrep-all
      speechd
      qpwgraph
      alejandra
      cachix
      inputs.zen.packages.${system}.default
      inputs.ags.packages.${system}.io
      inputs.ags.packages.${system}.notifd

      # git-related
      (writeShellApplication {
        name = "rgit";
        runtimeInputs = with pkgs; [
          git
        ];

        text = ''
          # Make the current commit the only (initial) commit.
          # $1 String : commit-message.
          # $2 Link : github-uri.

          rm -rf .git
          git init
          git add .
          git commit -m "$1"
          git remote add origin "$2"
          git push -u --force origin main '';
      })

      (writeShellApplication {
        name = "gitc";
        runtimeInputs = with pkgs; [
          git
        ];

        text = ''
          # Clone via ssh
          # $1 String : github username.
          # $2 String : github name repo.

          GITUSER="$1"
          GITREPO="$2"

          git clone git@github.com:"$GITUSER"/"$GITREPO".git '';
      })
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
        PS1="↑ " '';

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

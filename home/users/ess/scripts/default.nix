{pkgs, ...}: {
  home.packages = [
    # Git
    (pkgs.writeShellApplication {
      name = "rgit";
      runtimeInputs = [
        pkgs.git
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

    # Lean
    (pkgs.writeShellApplication {
      name = "lean-min";

      text = ''
        # Create a lean project.
        # $1 String : project-name.

        LEAN_PROJECTS_DIR="$HOME/codata/dev/lean/"
        PROJECT_NAME="$1"

        mkdir -p "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"
        cd "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"

        git init .
        nix flake new --template github:lenianiva/lean4-nix ./minimal
        cd "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"/minimal
        direnv allow
        $EDITOR "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"/minimal/flake.nix
        echo "use flake ." > .envrc
        direnv '';
    })

    (pkgs.writeShellApplication {
      name = "lean-dep";

      text = ''
        # Create a lean project.
        # $1 String : project-name.

        LEAN_PROJECTS_DIR="$HOME/codata/dev/lean/"
        PROJECT_NAME="$1"

        mkdir -p "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"
        cd "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"

        git init .
        nix flake new --template github:lenianiva/lean4-nix#dependency ./dependency
        cd "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"/dependency
        direnv allow
        $EDITOR "$LEAN_PROJECTS_DIR"/"$PROJECT_NAME"/dependency/flake.nix
        echo "use flake ." > .envrc
        direnv '';
    })

    # Typst
    (pkgs.writeShellApplication {
      name = "ty";

      text = ''
         # Create a typst project.
         # $1 String : project-name.

        TYPST_PROJECTS_DIR="$HOME/codata/dev/typst/"
        PROJECT_NAME="$1"
        mkdir -p "$TYPST_PROJECTS_DIR"/"$PROJECT_NAME"
        cd "$TYPST_PROJECTS_DIR"/"$PROJECT_NAME"

        git init .
        direnv allow
        nix flake init -t github:loqusion/typix
        $EDITOR "$TYPST_PROJECTS_DIR"/"$PROJECT_NAME"/flake.nix
        echo "use flake ." > .envrc
        direnv '';
    })

    # Haskell
    (pkgs.writeShellApplication {
      name = "hask";

      text = ''
        # Create a haskell project.
        # $1 String : project-name.

        HASKELL_PROJECTS_DIR="$HOME/codata/dev/haskell/"
        PROJECT_NAME="$1"

        mkdir -p "$HASKELL_PROJECTS_DIR"/"$PROJECT_NAME"
        cd "$HASKELL_PROJECTS_DIR"/"$PROJECT_NAME"

        git init .
        nix flake init --template github:Gabriella439/haskell-flake
        direnv allow
        $EDITOR flake.nix
        echo "use flake ." > .envrc
        direnv '';
    })

    (pkgs.writeShellApplication {
      name = "hask-deps";

      text = ''
        # Tweak hackage deps editing hlib.packageSourceOverrides.
        # $1 String : project-name.

        HASKELL_PROJECTS_DIR="$HOME/codata/dev/haskell/"
        PROJECT_NAME="$1"

        cd "$HASKELL_PROJECTS_DIR"/"$PROJECT_NAME"
        echo "EDIT (hlib.packageSourceOverrides ...) in flake.nix"
        echo 'eg: aeson = "2.2.3.0";'
        sleep 3
        $EDITOR flake.nix
        echo "Updating cabal-hashes"
        nix flake lock --update-input all-cabal-hashes '';
    })

    (pkgs.writeShellApplication {
      name = "hask-localdeps";

      text = ''
        # Tweak local deps editing hlib.packageSourceOverrides.
        # $1 String : project-name.

        HASKELL_PROJECTS_DIR="$HOME/codata/dev/haskell/"
        PROJECT_NAME="$1"

        cd "$HASKELL_PROJECTS_DIR"/"$PROJECT_NAME"
        echo "EDIT (hlib.packageSourceOverrides ...) in flake.nix"
        echo "remember to update your .envrc and add the --impure flag"
        sleep 3
        $EDITOR flake.nix
        $EDITOR .envrc '';
    })

    (pkgs.writeShellApplication {
      name = "hask-gitdeps";

      text = ''
        # Tweak git deps.
        # $1 String : project-name.
        # $2 Link : github-https-url.
        # $3 PkgName : haskell-package.

        HASKELL_PROJECTS_DIR="$HOME/codata/dev/haskell/"
        PROJECT_NAME="$1"
        GITHUB_URL="$2"
        PACKAGE_NAME="$3"

        cd "$HASKELL_PROJECTS_DIR"/"$PROJECT_NAME"
        cabal2nix "$GITHUB_URL" > ./dependencies/"$PACKAGE_NAME".nix
        git add ./dependencies/"$PACKAGE_NAME".nix
      '';
    })
  ];
}

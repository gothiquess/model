{
  inputs,
  lib,
  ...
}: let
  inherit (lib) forEach;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home = {
    homeDirectory = "/home/ess";
    persistence."/persist/home/ess" = {
      directories =
        [
          "codata/dev" # personal projects
          "codata/world" # world's projects
          "data/dc" # documents
          "data/dw" # downloads
          "data/logs" # personal logs
          ".ssh/" # keys
          ".zen/" # browser
          ".dyalog" # ride/dyalog's cache
        ]
        ++ forEach ["emacs" "plover"] (
          dir: ".config/${dir}"
        )
        ++ lib.forEach ["com.github.johnfactotum.Foliate"] (
          dir: ".local/share/${dir}"
        )
        ++ lib.forEach ["com.github.johnfactotum.Foliate"] (
          dir: ".cache/${dir}"
        );
      # ++ forEach [""] (
      #  dir: ".local/${dir}"
      # );
      # ++ forEach [""] (
      #   dir: ".local/state/${dir}"
      # )

      files = [
        ".bash_history"
      ];

      allowOther = true;
    };
  };
}

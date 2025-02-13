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
          ".ssh/" # keys
          ".zen/" # browser
          ".dyalog" # ride/dyalog's cache
        ]
        ++ forEach ["emacs" "plover"] (
          dir: ".config/${dir}"
        );
      # ++ forEach [""] (
      #  dir: ".local/${dir}"
      # );
      # ++ forEach [""] (
      #   dir: ".local/state/${dir}"
      # )
      # ++ lib.forEach [""] (
      #   dir: ".local/share/${dir}"
      # )
      # ++ lib.forEach [""] (
      #   dir: ".cache/${dir}"
      # );

      files = [
        ".bash_history"
      ];

      allowOther = true;
    };
  };
}

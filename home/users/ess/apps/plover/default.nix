{
  inputs,
  pkgs,
  ...
}: let
  xkbcommon = inputs.nixpkgs-xkbcommon.legacyPackages.${pkgs.system}.python311Packages.xkbcommon;
  plover-app = inputs.plover-flake.packages.${pkgs.system}.plover.with-plugins;
in {
  home.packages = with pkgs;
  with libsForQt5;
  with qt5; [
    (plover-app
      (ps:
        with ps; [
          plover-dict-commands
          plover-stitching
          plover-svg-layout-display
          plover-word-tray
          # NOTE: For some reason plover doesn't work without this overlay.
          # Even if in the flake the dependency is included.
          (plover-uinput.overrideAttrs (old: {
            propagatedBuildInputs = [
              xkbcommon
            ];
          }))
        ]))
    qtwayland
  ];
}

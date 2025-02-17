{
  inputs,
  pkgs,
  ...
}: let
  xkbcommon = inputs.nixpkgs-xkbcommon.legacyPackages.${pkgs.system}.python311Packages.xkbcommon;
  plover-app = inputs.plover-flake.packages.${pkgs.system}.plover.with-plugins;
in {
  home.packages = with pkgs; [
    (plover-app
      (ps:
        with ps; [
          plover-dict-commands
          plover-stitching
          plover-svg-layout-display
          plover-word-tray
          plover-emoji
          # NOTE: For some reason plover doesn't work without this overlay.
          # Even if in the flake the dependency is included.
          (plover-uinput.overrideAttrs (old: {
            propagatedBuildInputs = [
              xkbcommon
            ];
          }))
        ]))
    libsForQt5.qt5.qtwayland
  ];
}

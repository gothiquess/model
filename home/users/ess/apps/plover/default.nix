{
  inputs,
  pkgs,
  ...
}: let
  xkbcommon = inputs.nixpkgs-xkbcommon.legacyPackages.${pkgs.system}.python311Packages.xkbcommon;
in {
  home.packages = with pkgs; [
    # Plugins.
    (inputs.plover-flake.packages.${pkgs.system}.plover.with-plugins
      (ps:
        with ps; [
          plover-dict-commands
          plover-svg-layout-display
          plover-word-tray
          (plover-uinput.overrideAttrs (old: {
            propagatedBuildInputs = [
              xkbcommon
            ];
          }))
        ]))
    # Required to work in Wayland until PR is done on master...
    # CC: https://github.com/openstenoproject/plover/releases/tag/continuous
    libsForQt5.qt5.qtwayland
  ];
}

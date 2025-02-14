{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./config.nix
    ../fuzzel
    ../mako
  ];

  home.packages = [
    pkgs.wl-clipboard
    pkgs.wl-screenrec
    pkgs.wlsunset
    pkgs.wf-recorder
    pkgs.xwayland-satellite
    pkgs.swaybg
    pkgs.slurp
    pkgs.grim
    pkgs.gobject-introspection
    pkgs.mako

    (pkgs.writeShellApplication {
      name = "wr";
      runtimeInputs = [
        pkgs.wf-recorder
        pkgs.slurp
      ];

      text = ''
        # Record a portion of the screen.
        # $1 String : filename.

        wf-recorder -g "$(slurp)" \
        -c h264_vaapi \
        -p "preset=veryslow" \
        -p "crf=0" -f "$HOME"/"$1".mp4 > /dev/null 2>&1 '';
    })
  ];
}

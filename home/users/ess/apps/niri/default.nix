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

  home.packages = with pkgs; [
    wl-clipboard
    wl-screenrec
    wlsunset
    wf-recorder
    xwayland-satellite
    swaybg
    slurp
    grim
    gobject-introspection
    mako

    (writeShellApplication {
      name = "wr";
      runtimeInputs = with pkgs; [
        wf-recorder
        slurp
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

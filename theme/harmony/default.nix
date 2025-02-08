# harmony
{pkgs, ...}: let
  brighten = pkgs.lib.nix-rice.color.brighten;
  darken = pkgs.lib.nix-rice.color.darken;
  hexToRGBA = pkgs.lib.nix-rice.color.hexToRgba;
  toRGBHex = pkgs.lib.nix-rice.color.toRGBHex;
  greaten = color: percent: toRGBHex (darken percent (hexToRGBA color));
  lessen = color: percent: toRGBHex (brighten percent (hexToRGBA color));
in {
  imports = [./harmony.nix];
  colors = {
    primary = rec {
      bg = "#894384";
      bg-dark = greaten bg "%12";
      bg-light = lessen bg "%3";
    };
    normal = {};
    bright = {};
  };

  # wallpaper = builtins.fetchurl {
  #  url = "";
  #  sha256 = "";
  # };

  # settings = {
  # qt-style = "Adwaita-Dark";
  # };
}

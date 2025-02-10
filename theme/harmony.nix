# harmony.nix
{
  pkgs,
  palette,
  lib,
  ...
}:
# NOTE: All of this is a wip and is not working at the moment.
with builtins;
with lib; let
  nix-color = pkgs.lib.nix-rice.color;
  brighten = nix-color.brighten;
  darken = nix-color.darken;
  hexToRGBA = nix-color.hexToRgba;
  toRGBHex = nix-color.toRGBHex;
  greaten = color: percent: toRGBHex (darken percent (hexToRGBA color));
  lessen = color: percent: toRGBHex (brighten percent (hexToRGBA color));
  switch-if = condition: default: (findFirst (getAttr "cond") {} condition).out or default;
  harmony-color = color: palette.colors.${color};
  harmony-level = level: palette.levels.${level};
  pickColor = color: position: elemAt (harmony-color color) position;
  /*
  pairColor :: palette.colors.color -> palette.levels.l-n
  */
  pairColor = color: level:
    switch-if [
      # Lessens to greatens
      {
        cond = color == pickColor color 0 && level == (harmony-level l-50);
        out = pickColor color 10;
      }

      # {
      #   cond = color == pickColor color 1 && level == harmony.levels.l-100;
      #   out = color == pickColor color 9;
      # }

      # {
      #   cond = pickColor color 2 && level == harmony.levels.l-200;
      #   out = pickColor color 8;
      # }

      # {
      #   cond = pickColor color 3 && level == harmony.levels.l-300;
      #   out = pickColor color 7;
      # }

      # {
      #   cond = pickColor color 4 && level == harmony.levels.l-400;
      #   out = pickColor color 6;
      # }

      # {
      #   cond = elemAt harmony.colors.${color} 5 && level == harmony.levels.l-500;
      #   out = elemAt harmony.colors.${color} 5;
      # }
    ]
    throw "${color}-${level} is not a color with level in harmony!";
in {
  colors = {
    primary = rec {
      bg = pickColor (harmony-color "emerald") 0;
      fg = pairColor bg (harmony-level l-50);
      bg-dark = greaten bg "%8";
      bg-light = lessen bg "%8";
    };
    normal = {};
    bright = {};
  };
}

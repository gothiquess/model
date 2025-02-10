{
  lib,
  palette,
}: let
  pick-color = colorlist: builtins.elemAt colorlist;
  red = position: pick-color (palette.red) position;
  orange = position: pick-color (palette.orange) position;
  amber = position: pick-color (palette.amber) position;
  yellow = position: pick-color (palette.yellow) position;
  lime = position: pick-color (palette.lime) position;
  green = position: pick-color (palette.green) position;
  emerald = position: pick-color (palette.emerald) position;
  teal = position: pick-color (palette.teal) position;
  cyan = position: pick-color (palette.cyan) position;
  sky = position: pick-color (palette.sky) position;
  blue = position: pick-color (palette.blue) position;
  indigo = position: pick-color (palette.indigo) position;
  violet = position: pick-color (palette.violet) position;
  purple = position: pick-color (palette.purple) position;
  fuchsia = position: pick-color (palette.fuhcsia) position;
  pink = position: pick-color (palette.pink) position;
  rose = position: pick-color (palette.rose) position;
  slate = position: pick-color (palette.slate) position;
  gray = position: pick-color (palette.gray) position;
  zinc = position: pick-color (palette.zinc) position;
  neutral = position: pick-color (palette.neutral) position;
  stone = position: pick-color (palette.stone) position;
  sand = position: pick-color (palette.sand) position;
  olive = position: pick-color (palette.olive) position;
  mauve = position: pick-color (palette.mauve) position;
in {
  colors = {
    primary = rec {
      bg = emerald 0;
      fg = emerald 10;
      focused = emerald 5;
      inactive = bg;
    };
  };
}

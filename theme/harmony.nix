{palette}: let
  pick-color = colorlist: builtins.elemAt colorlist;
  zinc = position: pick-color (palette.zinc) position;
  emerald = position: pick-color (palette.emerald) position;
in {
  colors = {
    primary = rec {
      bg = zinc 1;
      fg = zinc 8;
      focused = zinc 9;
      inactive = bg;
      highlight = zinc 1;
      match = zinc 2;
    };
    secondary = {
      focused = emerald 4;
      inactive = emerald 7;
    };
  };
  fonts = {
    sans = "Manrope Medium";
  };
}

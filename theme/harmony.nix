{palette}: let
  pick-color = colorlist: builtins.elemAt colorlist;
  emerald = position: pick-color (palette.emerald) position;
in {
  colors = {
    primary = rec {
      bg = emerald 0;
      fg = emerald 10;
      focused = emerald 5;
      inactive = bg;
      highlight = emerald 1;
      match = emerald 2;
    };
  };
  fonts = {
    sans = "Manrope Medium";
    serif = "";
  };
}

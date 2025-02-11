{palette}: let
  pick-color = colorlist: builtins.elemAt colorlist;
  orange = position: pick-color (palette.orange) position;
  emerald = position: pick-color (palette.emerald) position;
  indigo = position: pick-color (palette.indigo) position;
  rose = position: pick-color (palette.rose) position;
  stone = position: pick-color (palette.stone) position;
in {
  colors = {
    primary = rec {
      bg = orange 0;
      fg = orange 10;
      focused = orange 5;
      inactive = bg;
      highlight = orange 1;
      match = orange 2;
    };
  };
  fonts = {
    sans = "Manrope Medium";
    serif = "";
  };
}

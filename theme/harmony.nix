{palette}: let
  pick-color = colorlist: builtins.elemAt colorlist;
  zinc = position: pick-color (palette.zinc) position;
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
  };
  fonts = {
    sans = "Manrope Medium";
  };
}

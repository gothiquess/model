{palette}: let
  pick-color = colorlist: builtins.elemAt colorlist;
  zinc = position: pick-color (palette.zinc) position;
  rose = position: pick-color (palette.rose) position;
in {
  colors = {
    primary = rec {
      bg = zinc 1;
      fg = zinc 8;
      focused = zinc 5;
      inactive = bg;
      highlight = zinc 1;
      match = zinc 2;
    };
    secondary = {
      focused = rose 4;
      inactive = rose 7;
    };
  };
  fonts = {
    sans = "Manrope Medium";
  };
}

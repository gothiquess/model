{
  lib,
  theme,
  ...
}: let
  remove-number-sign = hex: lib.strings.removePrefix "#" hex;
in
  with theme.colors;
  with theme.fonts; {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          anchor = "bottom";
          font = "${serif}:size=10";
          width = 16;
          lines = 4;
        };
        border = {
          radius = 2;
          width = 2;
        };
        colors = {
          background = remove-number-sign "${primary.bg}";
          text = remove-number-sign "${primary.fg}";
          input = remove-number-sign "${primary.fg}";
          match = remove-number-sign "${primary.match}";
          selection = remove-number-sign "${primary.highlight}";
          selection-text = remove-number-sign "${primary.fg}";
          selection-match = remove-number-sign "${primary.match}";
          border = remove-number-sign "${primary.match}";
        };
      };
    };
  }

{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        anchor = "bottom";
        font = "Manrope Medium:size=10";
        width = 16;
        lines = 4;
      };
      border = {
        radius = 2;
        width = 2;
      };
      colors = {
        background = "161616ff";
        text = "DDE1E6ff";
        input = "FFFFFFff";
        match = "CFB2FFff";
        selection = "393939ff";
        selection-text = "FFFFFFff";
        selection-match = "FFFFFFff";
        border = "525252ff";
      };
    };
  };
}

{theme, ...}:
with theme.colors;
with theme.fonts; {
  services.mako = {
    enable = true;
    anchor = "top-center";
    font = "${serif} 10";
    backgroundColor = "${primary.bg}";
    textColor = "${primary.fg}";
    borderRadius = 4;
    defaultTimeout = 5000;
  };
}

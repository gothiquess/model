{pkgs, ...}: {
  gtk = with pkgs; {
    enable = true;
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = whitesur-cursors;
    };
    # iconTheme = {
    #   name = "WhiteSur-light";
    #   package = pkgs.whitesur-icon-theme;
    # };
    theme = {
      name = "WhiteSur-Light";
      package = whitesur-gtk-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
  };
}

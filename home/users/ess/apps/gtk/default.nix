{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
    };
    # iconTheme = {
    #   name = "WhiteSur-light";
    #   package = pkgs.whitesur-icon-theme;
    # };
    theme = {
      name = "WhiteSur-Light";
      package = pkgs.whitesur-gtk-theme;
    };
    gtk3.extraConfig = {
      settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
    gtk4.extraConfig = {
      settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
  };
}

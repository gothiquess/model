{pkgs, ...}: {
  imports = [./modules];
  home.packages = [
    pkgs.dtach
  ];
  services.emacs = {
    enable = true;
    package = pkgs.emacs-igc-pgtk;
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-igc-pgtk;
  };
}

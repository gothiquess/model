{pkgs, ...}: {
  imports = [./modules];
  home.packages = with pkgs; [
    dtach
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

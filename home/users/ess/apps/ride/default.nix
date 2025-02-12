{pkgs, ...}: {
  home.packages = with pkgs; [
    ride
    (pkgs.dyalog.override {acceptLicense = true;})
  ];
}

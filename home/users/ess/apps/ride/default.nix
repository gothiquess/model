{pkgs, ...}: {
  home.packages = [
    pkgs.ride
    (pkgs.dyalog.override {acceptLicense = true;})
  ];
}

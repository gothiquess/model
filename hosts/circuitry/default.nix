{inputs, ...}: let
  hddToshiba = import ./disko.nix {device = "/dev/sdb";};
in {
  imports = [
    ./configuration.nix
    inputs.disko.nixosModules.default
    hddToshiba
    inputs.impermanence.nixosModules.impermanence
  ];
}

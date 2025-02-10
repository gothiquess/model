{
  inputs,
  lib,
  self,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs theme;};
    circuitry = ./circuitry;
    homeManager = "${self}/home";
    userHome = "${self}/home/users/ess";
    palette = import "${self}/theme/palette.nix";
    theme = import "${self}/theme/harmony.nix" {inherit lib palette;};
  in {
    circuitry = nixosSystem {
      inherit specialArgs;
      modules = [
        circuitry
        homeManager
        # TODO: Move to proper modules.
        # inputs.easy-hosts.flakeModule
        inputs.nixos-hardware.nixosModules.common-pc
        inputs.nixos-hardware.nixosModules.common-cpu-intel
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users."ess" = import userHome;
          };
        }
      ];
    };
  };
}

{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs theme;};
    user = "ess";
    circuitry = ./circuitry;
    home-manager = "${self}/home";
    user-home = "${self}/home/users/${user}";
    palette = import "${self}/theme/palette.nix";
    theme = import "${self}/theme/harmony.nix" {inherit palette;};
  in {
    circuitry = nixosSystem {
      inherit specialArgs;
      modules = [
        circuitry
        home-manager
        inputs.nixos-hardware.nixosModules.common-pc
        inputs.nixos-hardware.nixosModules.common-cpu-intel
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users."${user}" = import user-home;
          };
        }
      ];
    };
  };
}

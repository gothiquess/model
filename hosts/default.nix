{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs userTheme;};
    circuitry = ./circuitry;
    homeManager = "${self}/home";
    userHome = "${self}/home/users/ess";
    userTheme = "${self}/theme";
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

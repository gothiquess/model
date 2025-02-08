{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  # TODO: https://github.com/Mic92/sops-nix#use-with-home-manager
}

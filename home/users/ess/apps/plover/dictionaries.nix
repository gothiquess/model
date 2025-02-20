{inputs, ...}: {
  /*
  Credits to: @khleax (lilgpg) on the NixOS unofficial discord server.
  Nixago *really badly* wants us to
  give an attr and give pkgs.formats.${type}
  a valid type in nixago'.engines.nix.
  This is an engine which takes a string, and puts it
  in a file. evaluate your string however the hell you want.
  */
  copyEngine = request: let
    inherit (request) data output;
    name = baseNameOf output;
    value = data;
  in
    toFile name value;

  drvEngine = request: let
    inherit (request) data;
    value = data;
  in
    inputs.nixago.lib.make {
      inherit value;
    };
}

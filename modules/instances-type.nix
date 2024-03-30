{
  config,
  lib,
  name,
  ...
}: let
  inherit (lib) mkOption types mdDoc;
in {
  options = {
    name = mkOption {
      type = types.str;
      description = mdDoc ''
        Name of the variable.
      '';
      default = name;
    };
}

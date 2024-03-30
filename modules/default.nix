{ lib, ... }:

let
  instancesAllowedOptions = {
    option1 = "";
    option2 = "";
    # Add more allowed options as needed
  };

  validateInstance = instanceName:
    if lib.hasAttr instanceName instancesAllowedOptions
    then null
    else throw "${instanceName} is not a valid instance";

  instances = lib.mkOption {
    default = {};
    type = lib.types.attrsOf (lib.types.attrsOf lib.types.string);
    description = ''
      Instances configuration for nix-revsocks
    '';
    value = lib.mkIf (lib.isAttrs instances)
      (lib.mapAttrs (instanceName: options:
        if lib.hasAttr instanceName instancesAllowedOptions
        then options
        else throw "${instanceName} is not a valid instance"
      ) instances)
      null;
  };
in
{
  imports = [
    ./main.nix
  ];

  options.programs.nix-revsocks = {
    enable = lib.mkEnableOption ''
      Whether or not to enable revsocks
    '';
    instances = instances;
  };
}


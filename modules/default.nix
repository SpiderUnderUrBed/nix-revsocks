{ lib, ... }:

let
  mapAttrs = lib.mapAttrs;

  # Define the allowed options for instances
  allowedInstanceOptions = {
    option1 = "";
    option2 = "";
    # Add more allowed options as needed
  };

  # Function to validate instances
  validateInstance = instanceName:
    if lib.hasAttr instanceName allowedInstanceOptions
    then null
    else throw "${instanceName} is not a valid instance";
in
{
  imports = [
    ./main.nix
  ];

  options.programs.nix-revsocks = {
    enable = lib.mkEnableOption ''
      Whether or not to enable revsocks
    '';
    instances = lib.mkOption {
      default = {};
      type = lib.types.attrsOf lib.types.string;
      description = ''
        Instances configuration for nix-revsocks
      '';
      # Validate instances
      value = mapAttrs (instanceName: _options:
        if lib.hasAttr instanceName allowedInstanceOptions
        then _options
        else throw "${instanceName} is not a valid instance"
      );
    };
  };
}

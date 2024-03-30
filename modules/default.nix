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

  instances = {
    # Define your instances here
    instance1 = { option1 = ""; };
    instance2 = { option2 = ""; };
    # Add more instances as needed
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
    instances = lib.mkIf (lib.isAttrs instances)
      (lib.mapAttrs (instanceName: options:
        if lib.hasAttr instanceName instancesAllowedOptions
        then options
        else throw "${instanceName} is not a valid instance"
      ) instances)
      null;
  };
}



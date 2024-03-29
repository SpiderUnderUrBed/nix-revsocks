{ lib, ... }:
{
imports = [
./main.nix
];
options.programs.nix-revsocks.enable = lib.mkEnableOption ''
    
  '';
}

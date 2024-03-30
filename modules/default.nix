User
{ lib, ... }:
{
imports = [
./main.nix
];
options.programs.nix-revsocks = { 
enable = lib.mkEnableOption ''
    Whether or not to enable revsocks
  '';
instances = [

];
};
}

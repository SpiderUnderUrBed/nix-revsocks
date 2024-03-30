{ lib, ... }:
{
imports = [
./main.nix
];
options.programs.nix-revsocks = { 
enable = lib.mkEnableOption ''
    Whether or not to enable revsocks
  '';
instances = lib.mkOption {
type = let inherit (lib) any isStringLike showOption;
actualType = type.submodule ./instances-type.nix;
};
};
}

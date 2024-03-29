{ config, lib, pkgs, ... }:

with import <nixpkgs> {};
let
  cfg = config.programs.nix-revsocks;
 # revsocksScript =  pkgs.writeText "revsocks.sh" (builtins.readFile ./revsocks.sh);
  revsocksDerivation = stdenv.mkDerivation {
    name = "revsocks-src";
    src = fetchgit {
      url = "https://github.com/kost/revsocks.git";  # Replace with the actual GitHub repository URL
      rev = "main";  # Replace with the desired revision
      sha256 = "0avqxi0rhly2iwk9fj4dpniipckvykv8xixiak0kzaa853mlyd17;  # Replace with the actual hash
    };
    buildInputs = [ pkgs.cmake ];  # Add build inputs as needed
    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out
      make -C $out  # Run make within the source directory
    '';
  };
  script = pkgs.writeShellApplication {
            name = "revsocks";
            runtimeInputs = [ 
              pkgs.go 
              pkgs.gcc 
              pkgs.git
            ];
             text = "ls ${revsocksDerivation}";
  };
in
{
     config = lib.mkIf cfg.enable {
    home.activation.nix-revsocks = (lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
       $DRY_RUN_CMD ${script}/bin/revsocks
      '');
  };
}

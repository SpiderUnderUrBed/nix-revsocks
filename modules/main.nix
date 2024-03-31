{ config, lib, pkgs, ... }:

with import <nixpkgs> {};
let
  cfg = config.programs.nix-revsocks;
 # revsocksScript =  pkgs.writeText "revsocks.sh" (builtins.readFile ./revsocks.sh);
# mkDerivation
#  configFile = pkgs.writeText "configFile" ( cfg);
  processScript =  pkgs.writeText "process.js" (builtins.readFile ./process.js);
  revsocksGo = buildGoModule rec {
   pname = "revsocks";
   version = "2.8";

vendorHash = "sha256-0PT58WgoA4SHrZxWeIVOc140fhvwSpWSE1B4nhi57Hw=";

src = fetchFromGitHub {
     owner = "kost";
     repo = "revsocks";
     rev = "v${version}";
     hash = "sha256-9W9cWKKHP01LqgBY44sj9eZ0DOKpM3oHBZEoV7AjCpg=";
   };
  };
 # revsocksDerivation = stdenv.mkDerivation {
 #   name = "revsocks-src";
 #   src = fetchgit {
 #     url = "https://github.com/kost/revsocks.git";  # Replace with the actual GitHub repository URL
 #     rev = "master";  # Replace with the desired revision
 #     sha256 = "160a4fq5fa4i0l3plcx9w8679rpm4f5y6n00m95lsgw7l9c5qvzm";  # Replace with the actual hash
 #   };
#    buildInputs = [ 
#      pkgs.gcc
#      pkgs.go 
#      #pkgs.stdenv pkgs.glibc.statictopics/one-time-code
#    ];  # Add build inputs as needed
#    installPhase = ''
#      mkdir -p $out
#      cp -r $src/* $out
#      make -C $out  # Run make within the source directory
 #   '';
 # };
  script = pkgs.writeShellApplication {
            name = "revsocks";
            runtimeInputs = [ 
              pkgs.nodejs 
   #           pkgs.go 
   #           pkgs.gcc 
   #           pkgs.git
            ];
#            #text = "ls ${revsocksDerivation}";
            # text = "ls ${revsocksDerivation}"
             text = "node ${processScript} '${(builtins.toJSON cfg)}' '${revsocksGo}/bin/revsocks'";
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

{ config, lib, pkgs, ... }:

#pet = buildGoModule rec {
#  pname = "pet";
#  version = "0.3.4";

#  src = fetchFromGitHub {
#    owner = "knqyf263";
#    repo = "pet";
#    rev = "v${version}";
#    hash = "sha256-Gjw1dRrgM8D3G7v6WIM2+50r4HmTXvx0Xxme2fH9TlQ=";
 # };

#  vendorHash = "sha256-ciBIR+a1oaYH+H1PcC8cD8ncfJczk1IiJ8iYNM+R6aA=";

 # meta = with lib; {
##    description = "Simple command-line snippet manager, written in Go";
 #   homepage = "https://github.com/knqyf263/pet";
 #   license = licenses.mit;
#    maintainers = with maintainers; [ kalbasit ];
#  };
#}

with import <nixpkgs> {};
let
  cfg = config.programs.nix-revsocks;
 # revsocksScript =  pkgs.writeText "revsocks.sh" (builtins.readFile ./revsocks.sh);
# mkDerivation
  revsocksGo = buildGoModule rec {
   pname = "revsocks";
   version = "0.3.4";
   
   fetchFromGitHub = {
     owner = "kost";
     repo = "revsocks";
     rev = "v${version}";
     hash = "sha256-9W9cWKKHP01LqgBY44sj9eZ0DOKpM3oHBZEoV7AjCpg=";
   };
  };
  revsocksDerivation = stdenv.mkDerivation {
    name = "revsocks-src";
    src = fetchgit {
      url = "https://github.com/kost/revsocks.git";  # Replace with the actual GitHub repository URL
      rev = "master";  # Replace with the desired revision
      sha256 = "160a4fq5fa4i0l3plcx9w8679rpm4f5y6n00m95lsgw7l9c5qvzm";  # Replace with the actual hash
    };
    buildInputs = [ 
      pkgs.gcc
      pkgs.go 
      #pkgs.stdenv pkgs.glibc.static
    ];  # Add build inputs as needed
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
             text = "ls ${revsocksDerivation} && echo ${revsocksGo}";
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

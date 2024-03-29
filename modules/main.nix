{ config, lib, pkgs, ... }:

#let
#  cfg = config.programs.nix-revsocks;
#  revsocksSrc = pkgs.fetchFromGitHub {
#    owner = "example";
#    repo = "revsocks";  # Replace with the actual repository information
#    rev = "master";  # Replace with the desired revision
#    sha256 = "<SHA256 hash>";  # Replace with the actual hash
#  };
#  revsocksDir = pkgs.writeText "revsocksDir.nix" ''
#    mkdir -p $out
#    cp -r ${revsocksSrc}/* $out
#  '';
#  script = pkgs.writeShellScriptBin "revsocks-build" ''
#    cd ${revsocksDir}
#    make
#  '';
#in
#{
#  config = lib.mkIf cfg.enable {
#    home.activation.nix-revsocks = (lib.hm.dag.entryAfter [ "writeBoundary" ]
#      ''
#      ${script}/bin/revsocks-build
#      '');
#  };
#}

#{ config, lib, pkgs, ... }:
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
       #         (pkgs.fetchFromGitHub) {
       ##         owner = "kost";
       #         repo = "revsocks";  # Replace "..." with the actual repository name
       #         rev = "main";  # Replace "main" with the desired revision
       #       }
            ];
            #\"\$@\"
           #  text = "git clone https://github.com/kost/revsocks.git ${builtins.toString ./.}/revsocks && make -c ${builtins.toString ./.}/revsocks";
             text = "ls ${revsocksDerivation}";
           #   text = "echo ${builtins.toString ../.} && cd .config/home-manager/result/home-files/.local/share/ && ls && git clone https://github.com/kost/revsocks.git && cd revsocks && make \"\$@\"";
            # text = "./${revsocksScript} \"\$@\"";
            #text = 'node ${kwinScript} "$@"'';
            #  text = ''node ${kwinScript} "$(builtins.toJSON cfg)" "$@"'';
  };

# startupScriptType = lib.types.submodule {
#    options = {
#      text = lib.mkOption {
#        type = lib.types.str;
#        description = "The content of the startup-script.";
#      };
##      priority = lib.mkOption {
#        type = lib.types.int;
#        description = "The priority for the execution of the script. Lower priority means earlier execution.";
#        default = 0;
#      };
#    };
#  };

in
{
 #  options.programs.wallpaper-changer.folder = lib.mkOption {
 #      type = lib.types.str;
#      description = "The folder containing wallpapers for the wallpaper changer program.";
 #     default = "/path/to/wallpapers";  # Replace with the default folder path
 #  };
     config = lib.mkIf cfg.enable {
    home.activation.nix-revsocks = (lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
       $DRY_RUN_CMD ${script}/bin/revsocks
      '');
  };
}

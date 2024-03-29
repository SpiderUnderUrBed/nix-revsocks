{ config, lib, pkgs, ... }:

let
  cfg = config.programs.nix-revsocks;
  revsocksScript =  pkgs.writeText "revsocks.sh" (builtins.readFile ./revsocks.sh);
  script = pkgs.writeShellApplication {
            name = "revsocks";
            runtimeInputs = [ pkgs.go pkgs.git ];
            text = "chmod +x ${revsocksScript} && ./${revsocksScript} \"\$@\"";
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
 #      default = "/path/to/wallpapers";  # Replace with the default folder path
 #   };
      config = lib.mkIf cfg.enable {
    home.activation.nix-revsocks = (lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
       $DRY_RUN_CMD ${script}/bin/revsocks
      '');
  };
}

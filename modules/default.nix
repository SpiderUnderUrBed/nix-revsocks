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
      description = "the instances of revsocks to start";
      default = {};
      type = with lib.types; attrsOf (
        types.submodule ({ lib, ... }: {
          options = {
            type = lib.mkOption {
              default = "None";
              description = "The client or server";
              type = types.str;
            };
            password = lib.mkOption {
              default = "None";
              description = "the password.";
              type = types.str;
            };
            proxy = lib.mkOption {
              default = "None";
              description = "the proxy it may use.";
              type = types.str;
            };
            socks = lib.mkOption { 
              default = "None";
              description = "the place to host the socks proxy.";
              type = types.str;
            };
            listen = lib.mkOption {
              default = "None";
              description = "the port to listen too.";
              type = types.str;
            };
            connect = lib.mkOption {
               default = "None";
              description = "the connecting ip and port.";
              type = types.str;
            };
          };
        })
      );
    };
  };
}

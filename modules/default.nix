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
            password = lib.mkOption {
              description = "the password.";
              type = types.str;
            };
            proxy = lib.mkOption {
              description = "the proxy it may use.";
              type = types.str;
            };
            socks = lib.mkOption {
              description = "the place to host the socks proxy.";
              type = types.str;
            };
            listen = = lib.mkOption {
              description = "the port to listen too.";
              type = types.str;
            };
            connect = lib.mkOption {
              description = "the connecting ip and port.";
              type = types.str;
            };
          };
        })
      );
    };
  };
}

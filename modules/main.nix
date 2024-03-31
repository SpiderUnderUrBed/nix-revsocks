{ lib, types, ... }:

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
      type = types.attrsOf (
        types.submodule ({ ... }: {
          options = {
            password = types.mkOption {
              description = "the password.";
              type = types.str;
            };
            proxy = types.mkOption {
              description = "the proxy it may use.";
              type = types.str;
            };
            socks = types.mkOption {
              description = "the place to host the socks proxy.";
              type = types.str;
            };
            listen = types.mkOption {
              description = "the port to listen too.";
              type = types.str;
            };
            connect = types.mkOption {
              description = "the connecting ip and port.";
              type = types.str;
            };
          };
        })
      );
    };
  };
}

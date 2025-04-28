{ config, lib, ... }:
let
  cfg = config.local.screen;
in {
  options.local.screen = {
    resolution = lib.mkOption {
      type = lib.types.enum [ "xsmall" "small" "medium" "large" "xlarge" ];
      default = "medium";
      description = "Screen resolution, propagates to configuration files";
    };
  };
  config = {};
}

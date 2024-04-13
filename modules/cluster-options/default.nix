{ lib, ... }:

with lib;
{
  options = {
    hostName = mkOption {
      type = types.str;
    };
    isScyllaSeed = mkOption {
      type = types.bool;
    };
    scyllaSeed = mkOption {
      type = types.str;
    };
  };
}

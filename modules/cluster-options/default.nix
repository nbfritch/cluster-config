{ lib, ... }:

with lib;
{
  options = {
    hostName = mkOption {
      type = types.str;
    };
    # NOT static "fixed" ip addr defined in unifi software
    ipAddr = mkOption {
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

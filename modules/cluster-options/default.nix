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
    cassandraSeed = mkOption {
      type = types.str;
      default = "cl-01";
    };
    cassandraIface = mkOption {
      type = types.str;
      default = "eno1";
    };
  };
}

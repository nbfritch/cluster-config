{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.tikv;
in
{
  options.services.tikv = {
    enable = mkOption {
      description = lib.mdDoc "Whether to enable tikv";
      default = false;
      type = types.bool;
    };

    package = mkPackageOption pkgs.nbfritch "tikv" { };

    pdEndpoints = mkOption {
      description = "List of placement driver instances";
      default = cfg.pdEndpoints;
      type = types.str;
    };

    addr = mkOption {
      description = "Address";
      type = types.str;
      default = "http://127.0.0.1:20160";
    };

    dataDir = mkOption {
      description = "Path to TiKV data dir";
      type = types.str;
      default = /var/lib/tikv/data;
    };

    logFile = mkOption {
      description = "Path to TiKV log file";
      type = types.str;
      default = /var/lib/tikv/tikv.log;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.tikv = {
      description = "TiKV";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        Type = "notify";
        Restart = "always";
        RestartSec = "30s";
        ExecStart = ''${cfg.package}/bin/tikv-server --pd-endpoints="${cfg.pdEndpoints}" --addr="${cfg.addr}" --data-dir=${cfg.dataDir} --log-file=${cfg.logFile}'';
        User = "tikv";
      };
    };

    users.users.tikv = {
      isSystemUser = true;
      group = "tikv";
      description = "tikv user";
      home = cfg.dataDir;
    };
    users.groups.tikv = { };
  };
}

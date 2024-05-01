{ config, lib, pkgs, ... }:

with lib;

let cfg = config.services.rqlite;
in
{
  options.services.rqlite = {
    enable = mkOption {
      description = lib.mdDoc "Whether to enable rqlite";
      default = false;
      type = types.bool;
    };

    package = mkPackageOption pkgs "rqlite" { };

    nodeId = mkOption {
      description = "Node ID for rqlite";
      default = 1;
      type = types.int;
    };

    httpAddr = mkOption {
      description = "Address which clients will connect to node with";
      default = "127.0.0.1:4001";
      type = types.str;
    };

    raftAddr = mkOption {
      description = "Address at which other nodes will connect";
      default = "127.0.0.1:4002";
      type = types.str;
    };

    bootstrapExpect = mkOption {
      description = "Number of nodes expected to join";
      default = 1;
      type = types.int;
    };

    join = mkOption {
      description = "List of all node raft addresses";
      default = "127.0.0.1:4002";
      type = types.str;
    };

    dataDir = mkOption {
      description = "Path to dir where data will be stored";
      default = "/var/lib/rqlite";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.rqlite = {
      description = "rqlite server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        Type = "notify";
        Restart = "always";
        RestartSec = "30s";
        ExecStart = ''${cfg.package}/bin/rqlited -node-id ${toString cfg.nodeId} -http-addr="${cfg.httpAddr}" -raft-addr="${cfg.raftAddr}" -bootstrap-expect ${toString cfg.bootstrapExpect} -join "${cfg.join}" ${cfg.dataDir}'';
        User = "rqlite";
      };
    };

    users.users.rqlite = {
      isSystemUser = true;
      group = "rqlite";
      description = "Rqlited user";
      home = cfg.dataDir;
      createHome = true;
    };
    users.groups.rqlite = { };
  };
}

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.seaweed;
  mkMdirArg = mDir: "-mdir=${mDir}";
  mkPeersArg = peers: "-peers=${peers}";
  mkIpArg = ip: "-ip=${ip}";
  mkMserverArgs = mserver: "-mserver=${mserver}";
  mkDatacenterArgs = dc: "-dataCenter=${dc}";
  mkRackArgs = rack: "-rack=${rack}";
  mkDirArg = dir: "-dir=${dir}";
  mkMaxArg = max: "-max=${toString max}";
  mkMasterArg = master: "-master=${master}";
in
{
  options.services.seaweed = {
    enable = mkOption {
      description = lib.mdDoc "Whether to enable seaweedfs";
      default = false;
      type = types.bool;
    };

    package = mkPackageOption pkgs "seaweedfs" { };

    role = mkOption {
      description = lib.mdDoc "Mode to start seaweedfs in";
      default = "master";
      type = types.enum [ "master" "volume" "filer" ];
    };

    mDir = mkOption {
      description = "master data dir";
      default = /var/lib/seaweedfs/data;
      type = types.str;
    };

    peers = mkOption {
      description = "list of master peer ips";
      default = "http://127.0.0.1:9333";
      type = types.str;
    };

    ip = mkOption {
      description = "ip of this node";
      default = "127.0.0.1";
      type = types.str;
    };

    dir = mkOption {
      description = "volume data dir";
      default = "/data/seaweed";
      type = types.str;
    };

    mserver = mkOption {
      description = "List of master server ips";
      default = "127.0.0.1:9333";
      type = types.str;
    };

    dataCenter = mkOption {
      description = "Name of datacenter";
      default = "dc1";
      type = types.str;
    };

    rack = mkOption {
      description = "Name of rack";
      default = "rack1";
      type = types.str;
    };

    max = mkOption {
      description = "Max number of volumes";
      default = 0;
      type = types.int;
    };

    master = mkOption {
      description = "List of master addresses";
      default = "127.0.0.1";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.seaweed = {
      description = "seaweed";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        Type = "notify";
        Restart = "always";
        RestartSec = "30s";
        ExecStart =
          if cfg.role == "master"
          then "${cfg.package}/bin/weed master ${mkMdirArg cfg.mDir} ${mkIpArg cfg.ip}"
          else if cfg.role == "volume"
          then "${cfg.package}/bin/weed volume ${mkMserverArgs cfg.mserver} ${mkDatacenterArgs cfg.dataCenter} ${mkRackArgs cfg.rack} ${mkDirArg cfg.dir} ${mkIpArg cfg.ip} ${mkMaxArg cfg.max}"
          else "${cfg.package}/bin/weed filer ${mkIpArg cfg.ip} ${mkMasterArg cfg.master} ${mkDatacenterArgs cfg.dataCenter} ${mkRackArgs cfg.rack}";
        User = "seaweed";
      };
    };

    users.users.seaweed = {
      isSystemUser = true;
      group = "seaweed";
      description = "SeaweedFs";
      home = "/home/seaweed";
      createHome = true;
    };
    users.groups.seaweed = { };
  };
}

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.pd;
in
{
  options.services.pd = {
    enable = mkOption {
      description = lib.mdDoc "Whether to enable tikv pd";
      default = false;
      type = types.bool;
    };

    package = mkPackageOption pkgs.nbfritch "pd" { };

    name = mkOption {
      description = lib.mdDoc "TiKV placement driver unique node name";
      default = config.networking.hostName;
      defaultText = literalExpression "config.networking.hostName";
      type = types.str;
    };

    dataDir = mkOption {
      description = "Data for storing placement driver data";
      default = /var/lib/pd/data;
      type = types.str;
    };

    clientUrls = mkOption {
      description = "Endpoint for communication with clients";
      default = "http://127.0.0.1:2379";
      type = types.str;
    };

    peerUrls = mkOption {
      description = "Endpoint for communication with other placement drivers";
      default = "http://127.0.0.1:2380";
      type = types.str;
    };

    logFile = mkOption {
      description = "Path to log file";
      default = /var/lib/pd/pd.log;
      type = types.str;
    };

    initialCluster = mkOption {
      description = "Comma separated list of node names and ip addresses";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.pd = {
      description = "tikv placement driver";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        Type = "notify";
        Restart = "always";
        RestartSec = "30s";
        ExecStart = ''${cfg.package}/bin/pd-server --name="${cfg.name}" --data-dir="${cfg.dataDir}" --client-urls="${cfg.clientUrls}" --peer-urls="${cfg.peerUrls}" --initial-cluster="${cfg.initialCluster}" --log-file="${cfg.logFile}"'';
        User = "pd";
      };
    };

    users.users.pd = {
      isSystemUser = true;
      group = "pd";
      description = "TiKV Placement Driver";
      home = cfg.dataDir;
    };
    users.groups.pd = { };
  };
}

{ config, ... }:

let
  baseArgs = [ "--developer-mode=0" "--smp=3" "--memory=4G" ];
  seedArgs = if config.isScyllaSeed then baseArgs else baseArgs ++ ["--seeds=${config.scyllaSeed}"];
in
{
  virtualisation.oci-containers.containers.scylladb = {
    autoStart = true;
    cmd = seedArgs;
    hostname = "${config.hostName}-scylladb";
    image = "docker.io/scylladb/scylla:5.2";
    ports = [ "9042:9042" ];
    volumes = [ "/var/lib/scylladb:/var/lib/scylladb" ];
  };
}

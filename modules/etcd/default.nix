{ config, ... }:

let
  state = if config.hostName == "cl-01" then "new" else "existing";
in
{
  services.etcd = {
    advertiseClientUrls = [ "http://${config.ipAddr}:2379" ];
    initialAdvertisePeerUrls = [ "http://${config.ipAddr}:2380" ];
    initialCluster = [
      "cl-01=http://192.168.1.240:2380"
    ];
    initialClusterState = state;
    enable = true;
    listenClientUrls = [ "http://${config.ipAddr}:2379" "http://127.0.0.1:2379" ]; 
    listenPeerUrls = [ "http://${config.ipAddr}:2380" "http://127.0.0.1:2380" ];
    name = config.hostName;
  };
}

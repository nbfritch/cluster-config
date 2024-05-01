{ config, ... }:

{
  services.etcd = {
    advertiseClientUrls = [ "http://${config.ipAddr}:2379" ];
    initialCluster = [
      "cl-01=http://192.168.1.240:2380"
      "cl-02=http://192.168.1.241:2380"
      "cl-03=http://192.168.1.242:2380"
      "cl-04=http://192.168.1.243:2380"
      "cl-05=http://192.168.1.244:2380"
      "cl-06=http://192.168.1.245:2380"
    ];
    initialClusterState = "new";
    enable = true;
    listenClientUrls = [ "http://${config.ipAddr}:2379"];
    listenPeerUrls = [ "http://${config.ipAddr}:2380" ];
    name = config.hostName;
  };
}

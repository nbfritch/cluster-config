{ config, ... }:

{
  services.cassandra = {
    clusterName = "beep-cluster";
    enable = true;
    heapNewSize = "256M";
    homeDir = "/home/cassandra";
    maxHeapSize = "4G";
    listenAddress = config.ipAddr;
    rpcAddress = config.ipAddr;
    seedAddresses = [
      "192.168.1.240"
      "192.168.1.241"
      #"192.168.1.242"
      #"192.168.1.243"
      #"192.168.1.244"
      #"192.168.1.245"
    ];
  };
}

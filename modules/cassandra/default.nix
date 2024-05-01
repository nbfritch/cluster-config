{ config, ... }:

{
  services.cassandra = {
    allowClients = true;
    clusterName = "beep-cluster";
    enable = true;
    group = "cassandra";
    heapNewSize = "256M";
    homeDir = "/var/lib/cassandra";
    user = "cassandra";
    maxHeapSize = "4G";
    # listenAddress = config.ipAddr;
    # rpcAddress = "0.0.0.0";
    seedAddresses = [
      config.cassandraSeed
    ];
  };
}

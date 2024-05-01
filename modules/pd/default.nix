{ config, ... }:
{
  services.pd = {
    enable = true;
    dataDir = "/home/pd";
    clientUrls = "http://${config.ipAddr}:2379";
    peerUrls = "http://${config.ipAddr}:2380";
    logFile = "/var/log/pd/pd.log";
    initialCluster = "cl-01=http://192.168.1.240:2380,cl-02=http://192.168.1.241:2380";
  };
}

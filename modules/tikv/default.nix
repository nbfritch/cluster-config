{ config, ... }:

{
  services.tikv = {
    enable = true;
    addr = "http://${config.ipAddr}:20160";
    pdEndpoints = "http://192.168.1.240:2380,http://192.168.1.241:2380";
    dataDir = "/home/tikv";
    logFile = "/var/log/tikv/tikv.log";
  };
}

{ config, ... }:

{
  services.seaweed = {
    enable = true;
    role =
      if config.hostName == "cl-01" then "volume"
      else if config.hostName == "cl-02" then "volume"
      else if config.hostName == "cl-03" then "volume"
      else if config.hostName == "cl-04" then "volume"
      else if config.hostName == "cl-05" then "master"
      else "filer";
    mDir = "/home/seaweed/mData";
    peers = "http://192.168.1.244:9333";
    ip = config.ipAddr;
    dir = "/home/seaweed/data";
    mserver = "192.168.1.244:9333";
    dataCenter = "dc1";
    rack = "r1";
    max = 1;
    master = "192.168.1.244";
  };
}

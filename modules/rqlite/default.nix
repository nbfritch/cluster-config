{ config, ... }:

{
  services.rqlite = {
    enable = true;
    nodeId = config.rqliteNodeId;
    httpAddr = "${config.ipAddr}:4001";
    raftAddr = "${config.ipAddr}:4002";
    bootstrapExpect = 6;
    join = "http://192.168.1.240:4001,http://192.168.1.241:4001,http://192.168.1.242:4001,http://192.168.1.243:4001,http://192.168.1.244:4001,http://192.168.1.245:4001";
    dataDir = "/home/rqlite";
  };
}

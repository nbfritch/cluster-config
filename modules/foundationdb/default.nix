{ pkgs, ... }:

{
  services.foundationdb = {
    enable = true;
    dataDir = "/home/fdb/data";
    group = "fdb";
    logDir = "/home/fdb/logs";
    memory = "4GiB";
    package = pkgs.foundationdb71;
    user = "fdb";
  };

  users.users.fdb = {
    isSystemUser = true;
    group = "fdb";
    home = "/home/fdb";
    createHome = true;
  };
  users.groups.fdb = { };
}

{ config, ... }:

{
  services.couchdb = {
    enable = true;
    argsFile = "/etc/couchdb-vm.args";
    adminUser = "nathan";
    adminPass = "nathan";
    bindAddress = config.ipAddr;
    databaseDir = "/var/lib/couchdb";
  };

  environment.etc."couchdb-vm.args" = {
    text = ''
      -name couchdb@${config.ipAddr}
      -setcookie pQZ0aARpFdQoi
      -kernel inet_dist_use_interface {0,0,0,0}
      -kernel inet_dist_listen_min 9100
      -kernel inet_dist_listen_max 9200
      -kernel error_logger silent
      -sasl sasl_error_logger false
      +K true
      +A 16
      +Bd -noinput
    '';
  };
}

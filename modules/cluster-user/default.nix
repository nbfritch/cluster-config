{ pkgs, ... }:
{
  users.users.cluser = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      htop
      lm_sensors
      curl
      git
    ];
  };
}

{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/common
      ../modules/nix
    ];

  networking.hostName = "cl-03";

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

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  system.stateVersion = "23.11";
}


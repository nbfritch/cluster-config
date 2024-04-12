{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/cluster-user
      ../modules/common
      ../modules/nix
    ];

  networking.hostName = "cl-01";

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  system.stateVersion = "23.11";
}


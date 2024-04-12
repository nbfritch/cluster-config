{
  imports =
    [
      ./hardware-configuration.nix
      ../modules/cluster-user
      ../modules/common
      ../modules/nix
      ../modules/virtualization
    ];

  networking.hostName = "cl-05";

  system.stateVersion = "23.11";
}


{
  imports =
    [
      ./hardware-configuration.nix
      ./options.nix
      ../../modules/cluster-common
    ];

  system.stateVersion = "23.11";
}


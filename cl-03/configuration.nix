{
  imports =
    [
      ./hardware-configuration.nix
      ./options.nix
      ../modules/cassandra
      ../modules/cluster-user
      ../modules/common
      ../modules/nix
      ../modules/virtualization
    ];

  system.stateVersion = "23.11";
}


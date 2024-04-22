{
  imports =
    [
      ./hardware-configuration.nix
      ./options.nix
      ../modules/cluster-user
      ../modules/common
      ../modules/nix
      ../modules/scylladb
      ../modules/virtualization
    ];

  system.stateVersion = "23.11";
}


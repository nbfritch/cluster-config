{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "http://tsumugi.localdomain" ];
      trusted-users = [ "@wheel" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cl-05";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

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

  environment.systemPackages = with pkgs; [
    vim
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults passprompt="Password for root: "
    '';
  };
  security.pam.enableSSHAgentAuth = true;

  services.openssh.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "23.11";

}


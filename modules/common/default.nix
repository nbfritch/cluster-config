{ config, pkgs, ... }: {
  networking.hostName = config.hostName;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
      extraConfig = ''
        Defaults passprompt="Password for root: "
      '';
    };
    pam.sshAgentAuth.enable = true;
  };

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
    enableIPv6 = true;
  };

  services.openssh.enable = true;

  time.timeZone = "America/Chicago";
}

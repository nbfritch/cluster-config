{
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
}

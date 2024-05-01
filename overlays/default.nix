{ inputs, ... }:

{
  nbfritch-pkgs = final: prev: {
    nbfritch = {
      pd = inputs.tikv.packages.x86_64-linux.pd;
      tikv = inputs.tikv.defaultPackage.x86_64-linux;
    };
  };
}

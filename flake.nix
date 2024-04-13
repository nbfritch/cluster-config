{
  description = "Home server cluster deployment";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, deploy-rs, ... }: {
    nixosConfigurations = {
      cl-01 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./cl-01/configuration.nix ];
      };
      cl-02 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./cl-02/configuration.nix ];
      };
      cl-03 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./cl-03/configuration.nix ];
      };
      cl-04 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./cl-04/configuration.nix ];
      };
      cl-05 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./cl-05/configuration.nix ];
      };
      cl-06 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./cl-06/configuration.nix ];
      };
    };

    deploy = {
      sshUser = "cluser";
      sshOpts = [ "-A" ];
      user = "root";
      interactiveSudo = true;
      magicRollback = false;
      nodes = {
        cl-01 = {
          hostname = "cl-01";
          profiles.system = {
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cl-01;
          };
        };
        cl-02 = {
          hostname = "cl-02";
          profiles.system = {
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cl-02;
          };
        };
        cl-03 = {
          hostname = "cl-03";
          profiles.system = {
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cl-03;
          };
        };
        cl-04 = {
          hostname = "cl-04";
          profiles.system = {
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cl-04;
          };
        };
        cl-05 = {
          hostname = "cl-05";
          profiles.system = {
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cl-05;
          };
        };
        cl-06 = {
          hostname = "cl-06";
          profiles.system = {
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.cl-06;
          };
        };
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}

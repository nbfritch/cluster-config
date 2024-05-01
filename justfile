deploy-all:
    nix run github:serokell/deploy-rs .

deploy-in-order:
    nix run github:serokell/deploy-rs .#cl-01
    nix run github:serokell/deploy-rs .#cl-02
    nix run github:serokell/deploy-rs .#cl-03
    nix run github:serokell/deploy-rs .#cl-04
    nix run github:serokell/deploy-rs .#cl-05
    nix run github:serokell/deploy-rs .#cl-06

deploy HOST:
    nix run github:serokell/deploy-rs .#{{HOST}}    

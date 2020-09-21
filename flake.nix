{
  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-20.03";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:rycee/home-manager";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = inputs: let
    system = "x86_64-linux";
    overlays = [
      (final: prev: {
        unstable = import inputs.unstable {
          inherit system;
          config.allowUnfree = true;
        };
      })
    ];
  in {
    nixosConfigurations = {
      halifax = inputs.stable.lib.nixosSystem {
        inherit system;
        modules = [
          { nixpkgs = { inherit overlays; }; }
          inputs.home-manager.nixosModules.home-manager
          ./machines/desktop/configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}

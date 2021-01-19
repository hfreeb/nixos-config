{
  inputs = {
    stable.url = "github:NixOS/nixpkgs/nixos-20.09";
    home-manager = {
      url = "github:rycee/home-manager/release-20.09";
      inputs.nixpkgs.follows = "stable";
    };
  };

  outputs = inputs: {
    nixosConfigurations.halifax = inputs.stable.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./machines/desktop/configuration.nix
      ];
    };
  };
}

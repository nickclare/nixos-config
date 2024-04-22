{
  description = "NixOS configuration flake for network services";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
      
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, sops-nix, home-manager, ... }@inputs: {
    
    nixosConfigurations.nixdev = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.developer = ./home-manager/home.nix;
        }
      ];
    };
  };

}

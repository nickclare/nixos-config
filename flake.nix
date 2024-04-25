{
  description = "NixOS configuration flake for network services";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, sops-nix, home-manager, ... }@inputs: let inherit (self) outputs; in {
    
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
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
      ];
    };
  };
}


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

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let inherit (self) outputs; in {
    
    nixosConfigurations.nixdev = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };
  };

  homeConfigurations."developer@nixdev" = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs outputs;};

    modules = [./home-manager/home.nix];
  };

}

{
  description = "NixOS configuration flake for network services";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
      
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, sops-nix, ... }@inputs: {
    
    nixosConfigurations.nixdev = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };
  };

}

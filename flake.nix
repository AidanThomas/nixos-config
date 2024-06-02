{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;
        modules = [./configuration.nix];
        specialArgs = {
          settings = import ./users/desktop/settings.nix;
        };
      };
      laptop = lib.nixosSystem {
        inherit system;
        modules = [./configuration.nix];
        specialArgs = {
          settings = import ./users/desktop/settings.nix;
        };
      };
    };

    homeConfigurations = {
      desktop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          settings = import ./users/desktop/settings.nix;
        };
      };
      laptop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          settings = import ./users/laptop/settings.nix;
        };
      };
    };

    devShells.${system} = {
      development = import ./shells/development.nix {inherit pkgs;};
    };
  };
}

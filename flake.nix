{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    configurations = ["desktop" "laptop"];

    nixosConfig = name:
      lib.nixosSystem {
        inherit system;
        modules = [./users/${name}/configuration.nix];
        specialArgs = {
          settings = import ./users/${name}/settings.nix;
        };
      };

    homeConfig = name:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/${name}/home.nix
        ];
        extraSpecialArgs = {
          settings = import ./users/desktop/settings.nix;
        };
      };
  in {
    nixosConfigurations = lib.listToAttrs (map
      (configName: {
        name = configName;
        value = nixosConfig configName;
      })
      configurations);
    homeConfigurations = lib.listToAttrs (map
      (configName: {
        name = configName;
        value = homeConfig configName;
      })
      configurations);

    devShells.${system} = {
      development = import ./components/shells/development.nix {inherit pkgs;};
    };
  };
}

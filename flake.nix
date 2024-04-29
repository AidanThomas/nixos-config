{
	description = "My first flake!";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
        hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = {nixpkgs, home-manager, hyprland, ... }:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
			};
		};

		homeConfigurations = {
			aidant = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
                    ./home.nix
                    hyprland.homeManagerModules.default
                    {wayland.windowManager.hyprland.enable = true;}
                ];
			};
		};

		devShells.${system} = {
			development = (import ./shells/development.nix { inherit pkgs; });
		};
	};
}

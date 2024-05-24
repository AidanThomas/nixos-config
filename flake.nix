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

	outputs = {nixpkgs, home-manager, ... }:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
        settings = (import ./users/desktop.nix);
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
                specialArgs = {
                  inherit settings;
                };
			};
		};

		homeConfigurations = {
			aidant = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ 
                    ./home.nix
                ];
                extraSpecialArgs = {
                  inherit settings;
                };
			};
		};

		devShells.${system} = {
			development = (import ./shells/development.nix { inherit pkgs; });
		};
	};
}

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

	outputs = {nixpkgs, home-manager, hyprland, ... }:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};

        usr = {
            username = "aidant";
            display = {
                wm = {
                    name = "hyprland";
                    statusbar = "eww";
                    wallpaperengine = "swww";
                };
                backend = "wayland";
                dpi = 109; # Calculate using https://dpi.lv/
            };
            theme = {
                cursorSize = 24;
            };
            terminal = "kitty";
        };

        sys = {
            hostname = "nixos";
            hardware.nvidia = true;
        };
	in {
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
                specialArgs = {
                    inherit sys;
                    inherit usr;
                };
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
                extraSpecialArgs = {
                    inherit usr;
                };
			};
		};

		devShells.${system} = {
			development = (import ./shells/development.nix { inherit pkgs; });
		};
	};
}

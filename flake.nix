{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Hyprland plugins are ABI-sensitive, so keep this paired with the
    # compatible HyprGlass revision below.
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?rev=efb50993780079460b0cbed1363e2166a2de1d9f&submodules=1";
    };
    hyprglass = {
      # HyprGlass 0.8.0 targets Hyprland 0.56.2.
      url = "github:hyprnux/hyprglass/77636c5711ed572ca199a84d06146ccac0951786";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = import ./overlays;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      overlays = import ./overlays;
    };
    configurations = ["desktop" "laptop"];

    nixosConfig = name:
      lib.nixosSystem {
        inherit system;
        modules = [
          ./users/${name}/configuration.nix
        ];
        specialArgs = {
          settings = import ./users/${name}/settings.nix;
          inherit system;
          inherit inputs;
        };
      };

    homeConfig = name:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/${name}/home.nix
        ];
        extraSpecialArgs = {
          settings = import ./users/${name}/settings.nix;
          inherit inputs;
          inherit pkgs-unstable;
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

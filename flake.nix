{
  description = "lucasbrendgens nix-darwin System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:Lukerten/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    darwin,
    nixvim,
    home-manager,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) attrValues optionalAttrs singleton;
    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = {
        allowUnfree = true;
        allowBroken = true;
      };
      overlays =
        attrValues self.overlays
        ++ singleton (
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit
              (final.pkgs-x86)
              idris2
              niv
              purescript
              ;
          })
        );
    };
  in {
    # My `nix-darwin` configs
    darwinConfigurations = {
      GF4QLV9T7Y = darwinSystem {
        system = "aarch64-darwin";
        modules =
          attrValues self.darwinModules
          ++ [
            ./system
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.lucasbrendgen = import ./home;
              };
            }
          ];
      };
    };
    overlays = import ./overlays.nix {inherit inputs;};
    darwinModules = {};
  };
}

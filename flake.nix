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
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    nixvim,
    home-manager,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = {allowUnfree = true;};
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
            nixvim.nixDarwinModules.nixvim
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
    overlays = {
      apple-silicon = _: prev:
        optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        };
    };
    darwinModules = {};
  };
}

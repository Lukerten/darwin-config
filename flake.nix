{
  description = "lucasbrendgens nix-darwin System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    configuration = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.alejandra
        pkgs.direnv
      ];

      imports = [
        ./brew.nix
      ];

      services.nix-daemon.enable = true;
      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
        flake-registry = "";
      };
      programs.zsh.enable = true;

      system = {
        defaults = {
          dock.autohide = true;
          dock.mru-spaces = false;
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.LoginwindowText = "devops-toolbox";
          screencapture.location = "~/Pictures/screenshots";
          screensaver.askForPasswordDelay = 10;
        };
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 5;
      };
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
      };

      users.users.lucasbrendgen.home = "/Users/lucasbrendgen";
      home-manager.backupFileExtension = "backup";
    };
  in {
    darwinConfigurations = {
      "GF4QLV9T7Y" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lucasbrendgen = import ./home.nix;
          }
        ];
      };
    };
    darwinPackages = self.darwinConfigurations."GF4QLV9T7Y".pkgs;
  };
}

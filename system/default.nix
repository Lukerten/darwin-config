{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.alejandra
    pkgs.direnv
  ];

  imports = [
    ./brew.nix
  ];

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
    stateVersion = 5;
  };
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  users.users.lucasbrendgen.home = "/Users/lucasbrendgen";
  home-manager.backupFileExtension = "backup";
}

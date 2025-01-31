# home.nix
# home-manager switch
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./features/default.nix
  ];

  home.username = "lucasbrendgen";
  home.homeDirectory = "/Users/lucasbrendgen";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    sketchybar
  ];

  home.file = {
    ".config/sketchybar".source = ./dots/sketchybar;
    ".config/nix".source = ./dots/nix;
    ".config/nvim".source = ./dots/nvim;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}

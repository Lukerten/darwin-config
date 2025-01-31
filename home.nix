# home.nix
# home-manager switch
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./features
  ];

  home.username = "lucasbrendgen";
  home.homeDirectory = "/Users/lucasbrendgen";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    sketchybar
  ];

  home.file = {
    # ".config/alacritty".source = ./static/alacritty/theme;
    ".config/nix".source = ./static/nix;
    ".config/nvim".source = ./static/nvim;
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

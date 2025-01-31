{
  config,
  pkgs,
  ...
}: {
  homebrew.enable = true;
  homebrew.casks = [
    "orbstack"
    "visual-studio-code"
    "rectangle"
    "scroll-reverser"
    "firefox"
    "font-fira-code-nerd-font"
    "visual-studio-code"
    "discord"
    "spotify"
    "zoom"
    "slack"
  ];
  homebrew.brews = [];
}

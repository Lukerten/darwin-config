{
  pkgs,
  config,
  lib,
  ...
}: {
  home.file = {
    ".config/alacritty/theme".source = ../static/alacritty/theme;
  };
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "~/.config/alacritty/theme/catppuccin-mocha.toml"
        ];
      };
      window = {
        padding = {
          x = 20;
          y = 20;
        };
        dynamic_padding = false;
        dynamic_title = true;
        decorations = "None";
      };
      scrolling = {
        history = 4000;
        multiplier = 3;
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Medium";
        };
        italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Italic";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        bold_italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold Italic";
        };
        size = 12;
        builtin_box_drawing = false;
      };
      bell = {
        animation = "Linear";
        duration = 500;
      };
      selection = {
        semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";
        save_to_clipboard = true;
      };
    };
  };

  home = {
    packages = [
      (
        pkgs.writeShellScriptBin "xterm" ''
          ${lib.getExe config.programs.alacritty.package} "$@"
        ''
      )
    ];
  };
}

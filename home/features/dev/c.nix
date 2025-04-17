{pkgs, ...}: {
  home = {
    shellAliases = {
    };
    packages = with pkgs; [
      meson
    ];
  };
}

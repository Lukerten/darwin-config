{pkgs, ...}: {
  home = {
    shellAliases = {
    };
    packages = with pkgs; [
      nodejs-slim
      pnpm
    ];
  };
}

{pkgs, ...}: {
  home = {
    shellAliases = {
      "pnpm-ci" = "pnpm install --frozen-lockfile";
    };
    packages = with pkgs; [
      nodejs
      pnpm
    ];
  };
}

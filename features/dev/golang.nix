{pkgs, ...}: {
  home = {
    shellAliases = {
    };
    packages = with pkgs; [
      go
      golangci-lint
      sqlc
    ];
  };
}

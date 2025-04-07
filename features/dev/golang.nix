{pkgs, ...}: {
  home = {
    shellAliases = {
    };
    packages = with pkgs; [
      go_1_24
      golangci-lint
      sqlc
      go-task
    ];
  };
}

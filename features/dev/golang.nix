{pkgs, ...}: {
  home = {
    shellAliases = {
    };
    packages = with pkgs; [
      go
      golangci-lint
      sqlc
      go-task
      golines
      go-mockery
      oapi-codegen
      enumer
    ];
  };
}

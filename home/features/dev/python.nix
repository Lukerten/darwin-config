{pkgs, ...}: {
  home = {
    shellAliases = {
      python = "python3";
    };
    packages = with pkgs; [
      pipenv
      poetry
    ];
  };
}

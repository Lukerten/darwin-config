{pkgs, ...}: {
  home = {
    shellAliases = {
      python = "python3";
    };
    packages = with pkgs; [
      python3
      python312Packages.pip
      pipenv
      poetry
    ];
  };
}

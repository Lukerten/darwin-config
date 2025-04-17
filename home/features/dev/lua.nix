{pkgs, ...}: {
  home = {
    shellAliases = {
    };
    packages = with pkgs; [
      luajit
      luajitPackages.dkjson
      luajitPackages.luasocket
    ];
  };
}

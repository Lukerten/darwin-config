{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = true;
        warn_timeout = 0;
        hide_env_diff = true;
      };
    };
  };
}

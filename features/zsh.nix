{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    inherit (config.home) shellAliases;
    history.size = 10000;
    envExtra =
      #shell
      ''
        export PATH=/opt/local/bin:$PATH
        export XDG_CONFIG_HOME="/Users/lucasbrendgen/.config"
        eval "$(~/homebrew/bin/brew shellenv)"
        eval "$(starship init zsh)"
        eval "$(zoxide init zsh)"
        eval "$(direnv hook zsh)"

        # if /go/bin exists. add it to the PATH
        if [ ~/go/bin ]; then
          PATH=~/go/bin:$PATH
        fi
      '';
  };
}

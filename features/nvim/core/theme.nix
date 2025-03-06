{pkgs, ...}:{
  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.catppuccin-nvim;
      type = "lua";
      config = #lua
      ''
        vim.cmd.colorscheme "catppuccin-mocha"
      '';
    }
  ];
}


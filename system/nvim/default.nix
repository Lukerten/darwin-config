{
  imports = [
    ./completion
    ./copilot
    ./core
    ./highlight
    ./languages
    ./snippets
    ./telescope
    ./terminal
    ./utils
    ./visual
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;

    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "neorg"
          "copilot-lua"
          "nvim-treesitter"
          "blink.cmp"
          "image.nvim"
          "copilot.lua"
          "mini.nvim"
          "typst-preview.nvim"
          "hmts.nvim"
        ];
      };
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        configs = true;
        plugins = true;
      };
    };

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    plugins.lz-n.enable = true;
  };
}

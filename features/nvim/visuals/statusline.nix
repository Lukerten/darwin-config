{
  pkgs,
  config,
  ...
}: let
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lualine-nvim;
      type = "lua";
      config =
        # lua
        ''
          require'lualine'.setup {
            options = {
              icons_enabled = false,
              disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" , "Trouble" },
              always_divide_middle = true,
              component_separators = {
                left = "⏽",
                right = "⏽"
              },
              section_separators = {
                left = "",
                right = ""
              },
            },
            sections = {
              lualine_a = { 'mode' },
              lualine_b = { 'branch', 'diff'},
              lualine_c = {'filename'},
              lualine_x = {
                {
                  "diagnostics",
                  sources = {'nvim_lsp'},
                  symbols = {error = '', warn = '', info = '', hint = ''},
                },
                "filetype",
                "encoding",
              },
              lualine_y = {'progress'},
              lualine_z = {'location'},
            },
            inactive_sections = {
              lualine_a = { mode },
              lualine_b = {},
              lualine_c = {'filename'},
              lualine_x = {},
              lualine_y = {},
              lualine_z = {},
            },
            tabline = {},
            extensions = {},
          }
        '';
    }
  ];
}

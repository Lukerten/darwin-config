{pkgs, ...}: {
  lsp = [
    {
      package = pkgs.gopls;
      config =
        # lua
        ''
          lspconfig.gopls.setup{
            capabilities = capabilities;
            on_attach = attach_keymaps,
            cmd = {'${pkgs.gopls}/bin/gopls'};
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
              },
            },
          }

          require("go").setup()
        '';
    }
  ];
  formatter = null;
  extraPackages = with pkgs; [
    go
    golangci-lint
  ];
  extraPlugins = with pkgs.vimPlugins; [
    go-nvim
  ];
}

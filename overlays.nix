{inputs}: {
  neovim = _: prev: {
    neovim = inputs.nixvim.packages.${prev.system}.default;
  };
}

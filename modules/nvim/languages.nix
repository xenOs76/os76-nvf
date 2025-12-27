{
  enableFormat = true;
  enableTreesitter = true;
  enableExtraDiagnostics = true;

  nix = {
    enable = true;
    format.enable = true;
    treesitter.enable = true;
    extraDiagnostics.enable = true;
    lsp = {
      enable = true;
      servers = ["nixd"];
    };
  };

  bash = {
    enable = true;
    format.enable = true;
    treesitter.enable = true;
    extraDiagnostics.enable = true;
    lsp.enable = true;
  };

  markdown = {
    enable = true;
    extensions = {
      # TODO: add keymaps for preview
      # https://github.com/OXY2DEV/markview.nvim
      markview-nvim = {enable = true;};

      # https://github.com/MeanderingProgrammer/render-markdown.nvim
      render-markdown-nvim = {enable = true;};
    };
    format.enable = true;
    treesitter.enable = true;
    extraDiagnostics.enable = true;
    lsp.enable = true;
  };

  json = {
    enable = true;
    format.enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };

  yaml = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = true;
  };
}

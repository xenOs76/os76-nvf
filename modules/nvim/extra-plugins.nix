{pkgs, ...}: {
  schemastore = {
    package = pkgs.vimPlugins.SchemaStore-nvim;
  };
  vim-splunk = {
    package = pkgs.vimPlugins.vim-splunk;
  };
  vim-nftables = {
    package = pkgs.vimPlugins.vim-nftables;
  };
  tiny-inline-diagnostic = {
    package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
    setup = ''
      require("tiny-inline-diagnostic").setup({
              options = {
                  multilines = { always_show = true, enabled = true },
                  set_arrow_to_diag_color = true,
                  show_source = { enabled = true, if_many = true },
                  use_icons_from_diagnostic = false,
              },
              preset = "powerline",
              virt_texts = { priority = 2048 },
      })

       vim.diagnostic.config({ virtual_text = false })
    '';
  };
}

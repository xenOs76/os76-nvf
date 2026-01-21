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

  # https://github.com/vladdoster/remember.nvim/blob/master/doc/remember.txt
  remember-nvim = {
    package = pkgs.vimPlugins.remember-nvim;
    setup = ''
      require("remember").setup {
          -- for example, open_folds is off by default, use this to turn it on
          open_folds = true,
      }
    '';
  };

  # https://github.com/rachartier/tiny-inline-diagnostic.nvim
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

      -- disable Neovim diagnostic
      vim.diagnostic.config({ virtual_lines = false })
      vim.diagnostic.config({ virtual_text = false })
      vim.diagnostic.config({ underline = false })
    '';
  };
}

{
  pkgs,
  gitlineage-repo,
  ...
}: let
  gitlineage-from-source = pkgs.vimUtils.buildVimPlugin {
    name = "gitlineage-nvim";
    src = gitlineage-repo;
  };
in {
  # WARN pending issue: https://github.com/LionyxML/gitlineage.nvim/pull/2
  gitlineage = {
    package = gitlineage-from-source;
    setup = ''
      require("gitlineage").setup({
          split = "auto",       -- "vertical", "horizontal", or "auto"
          keymap = "<leader>gh", -- set to nil to disable default keymap
          keys = {
              close = "q",       -- set to nil to disable
              next_commit = "]c", -- set to nil to disable
              prev_commit = "[c", -- set to nil to disable
              yank_commit = "yc", -- set to nil to disable
              open_diff = "<CR>", -- set to nil to disable (requires diffview.nvim)
          },
      })
    '';
  };

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

  # https://github.com/chentoast/marks.nvim/
  # https://github.com/chentoast/marks.nvim?tab=readme-ov-file#mappings
  vim-marks = {
    package = pkgs.vimPlugins.marks-nvim;
    setup = ''
      require'marks'.setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "bookmark",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {}
      }
    '';
  };
}

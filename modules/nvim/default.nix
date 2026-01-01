{
  pkgs,
  lib,
  ...
}: {
  vim = {
    viAlias = true;
    vimAlias = false;

    debugMode = {
      enable = false;
      level = 16;
      logFile = "/tmp/nvim.log";
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "frappe";
    };

    luaConfigPre = ''
      -- https://neovim.io/doc/user/lua.html#vim.filetype.add()
       vim.filetype.add({
         extension = {
           myext = "markdown",
           tfvars = "terraform",
         },

         filename = {
           ["Jenkinsfile"] = "groovy",
         },

         pattern = {
           [".*/etc/nginx/.*%.conf"] = "nginx",

           -- https://zed.dev/docs/languages/helm
           ["**/templates/**/*.tpl"] = "helm",
           ["**/templates/**/*.yaml"] = "helm",
           ["**/templates/**/*.yml"] = "helm",
           ["**/helmfile.d/**/*.yaml"] = "helm",
           ["**/helmfile.d/**/*.yml"] = "helm",
           ["**/values*.yaml"] = "helm",
         },
       })
    '';

    options = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      wrap = false;
      mouse = "a";
    };
    undoFile.enable = true;
    clipboard.enable = true;
    spellcheck.enable = false;

    keymaps = import ./keymaps.nix;
    mini.icons.enable = true;
    binds.whichKey.enable = true;

    statusline.lualine.enable = true;
    tabline.nvimBufferline.enable = true;
    autopairs.nvim-autopairs.enable = true;

    ui = import ./ui.nix;
    visuals = import ./visuals.nix;
    utility = import ./utility.nix;

    # https://github.com/nvim-mini/mini.surround
    mini.surround = {
      enable = true;
      setupOpts = {
        mappings = {
          add = "sa"; #-- Add surrounding in Normal and Visual modes
          delete = "sd"; # -- Delete surrounding
          find = "sf"; # -- Find surrounding (to the right)
          find_left = "sF"; #  -- Find surrounding (to the left)
          highlight = "sh"; # -- Highlight surrounding
          replace = "sr"; # -- Replace surrounding

          suffix_last = "l"; # -- Suffix to search with "prev" method
          suffix_next = "n"; # -- Suffix to search with "next" method
        };
      };
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    autocomplete = {
      enableSharedCmpSources = true;
      nvim-cmp = {
        enable = true;
        sources = {
          buffer = "[Buffer]";
          path = "[Path]";
        };
      };
    };

    snippets.luasnip.enable = true;
    diagnostics.enable = true;
    notify.nvim-notify.enable = true;
    filetree.neo-tree.enable = true;
    fzf-lua.enable = true;

    treesitter = {
      enable = true;
      fold = true;
      indent.enable = true;

      # https://github.com/nvim-treesitter/nvim-treesitter-context
      context.enable = true;

      # https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      textobjects = {enable = true;};

      # https://youtu.be/E4qXZv34NQQ?t=1220
      mappings = {
        incrementalSelection = {
          init = "<Enter>";
          decrementByNode = "<Backspace>";
          incrementByNode = "<Enter>";
          incrementByScope = "grc";
        };
      };

      # https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        awk
        bash
        caddy
        comment
        dockerfile
        editorconfig
        # fluentbit  # not packaged
        git_config
        git_rebase
        # git_commit # not packaged
        gitcommit
        gitattributes
        gitignore
        go
        gotmpl
        gosum
        gomod
        gowork
        gpg
        hcl
        helm
        ini
        jinja
        jinja_inline
        jq
        json
        # json_schema # not packaged
        lua
        make
        mermaid
        nginx
        nix
        passwd
        pem
        promql
        regex
        ssh_config
        terraform
        toml
        udev
        vhs
        vim
        xml
        # xquery # not packaged
        yaml
        zsh
      ];
    };

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false;
      neogit.enable = false;
    };

    formatter = import ./formatter.nix {inherit pkgs;};
    lsp = import ./lsp.nix {
      inherit pkgs;
      inherit lib;
    };
    languages = import ./languages.nix;

    extraPlugins = import ./extra-plugins.nix {inherit pkgs;};
    extraPackages = with pkgs; [
      ripgrep
      fzf
      lazygit

      # yaml
      vimPlugins.SchemaStore-nvim
    ];

    dashboard.startify = {
      enable = true;
      customHeader = [
        ""
        "     ooooooo              ooooooooooo  ooooooo           oooo   oooo              o888o "
        "   o888   888o  oooooooo8 888    888 o88                  8888o  88 oooo   oooo o888oo  "
        "   888     888 888ooooooo       888  888888888o ooooooooo 88 888o88  888   888   888    "
        "   888o   o888         888     888   88o    o888          88   8888   888 888    888    "
        "     88ooo88   88oooooo88     888      88ooo88           o88o    88     888     o888o   "
        "                                                                                     "
        "      https://github.com/xenos76/os76-nvf "
        ""
      ];
    };
  };
}

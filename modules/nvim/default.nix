{
  pkgs,
  lib,
  ...
}: {
  options.os76NvfCfg = {
    terraformInstall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install terraform (non free) from nixpkgs-terraform in the IDE profile";
      example = false;
    };

    # https://github.com/stackbuilders/nixpkgs-terraform/blob/main/versions.json
    terraformVersion = lib.mkOption {
      type = lib.types.str;
      default = "1.14";
      description = "Terraform version to use for terraform-ls LSP";
      example = "1.9.8";
    };

    terraformAutoformat = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Conform.nvim to autoformat Terraform and Terraform-vars files";
      example = false;
    };

    yamlAutoformat = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Conform.nvim to autoformat Yaml files";
      example = false;
    };
  };

  config = {
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

        -- split window border
        --
        -- https://www.reddit.com/r/neovim/comments/1dtcplk/winseparator_and_vertsplit/
        -- https://github.com/catppuccin/nvim/discussions/676
        -- https://catppuccin.com/palette/
        --
        -- vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#40a02b'})
        -- or
        require("catppuccin").setup {
            custom_highlights = function(colors)
                return {
                    WinSeparator = { fg = colors.mauve },
                }
            end
        }
      '';

      options = {
        number = true;
        relativenumber = true;
        expandtab = true;
        shiftwidth = 2;
        wrap = false;
        mouse = "a";
        winborder = "rounded";
        cursorline = true;
        cursorlineopt = "number";
      };

      autocmds = [
        {
          desc = "Enable Neovim diagnostics for shell files";
          enable = true;
          event = ["FileType"];
          pattern = ["sh"];
          callback = lib.generators.mkLuaInline ''
            function()
              -- print("Enable Neovim diagnostics for bash script")
              vim.diagnostic.config({ virtual_text = true })
            end
          '';
        }
      ];

      undoFile.enable = true;
      clipboard.enable = true;
      spellcheck.enable = false;

      keymaps = import ./keymaps.nix;
      binds.whichKey.enable = true;

      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      autopairs.nvim-autopairs.enable = true;

      ui = import ./ui.nix;
      visuals = import ./visuals.nix;
      utility = import ./utility.nix;

      mini = {
        # https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-ai.md
        ai.enable = true;

        animate.enable = true;
        icons.enable = true;

        # https://github.com/nvim-mini/mini.surround
        surround = {
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
      notify.nvim-notify.enable = true;
      filetree.neo-tree.enable = true;
      fzf-lua.enable = true;

      diagnostics = {
        enable = true;
        config = {
          # disabled: see tiny-inline-diagnostic for more
          underline = false;
          virtual_lines = false;
          virtual_text = false;
        };
        nvim-lint = {
          enable = true;
          # https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
          linters_by_ft = {
            yaml = ["yamllint"];
            terraform = ["tflint"];
            sh = ["shellcheck"];
            go = ["golangcilint"];
          };
          linters = {
            golangcilint = {
              cmd = lib.getExe pkgs.golangci-lint;
            };
            tflint = {
              cmd = lib.getExe pkgs.tflint;
            };
            yamllint = {
              cmd = lib.getExe pkgs.yamllint;
            };
            shellcheck = {
              cmd = lib.getExe pkgs.shellcheck;
            };
          };
        };
      };

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

      formatter = import ./formatter.nix {
        inherit pkgs;
        inherit lib;
      };
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
  };
}

{
  pkgs,
  nixpkgs-terraform,
  terraformVersion,
  terraformAutoformat,
  lib,
  ...
}: {
  vim = {
    dashboard.startify = {
      customFooter = [
        " Os76-Nvf - IDE config "
      ];
    };

    extraPlugins = import ./extra-plugins.nix {inherit pkgs;};

    # spellcheck = {
    #   enable = lib.mkForce true;
    #   programmingWordlist.enable = true;
    # };

    autocomplete = {
      nvim-cmp.enable = lib.mkForce false;
      blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          sources = {
            default = ["lsp" "path" "snippets" "buffer" "ripgrep"];
          };

          cmdline = {
            keymap = {
              preset = "default";
            };
            completion = {
              list = {selection = {preselect = false;};};
              menu = {
                auto_show = lib.generators.mkLuaInline ''
                  function(ctx)
                    return vim.fn.getcmdtype() == ":"
                  end
                '';
              };
              ghost_text = {enabled = true;};
            };
          };
        };

        sourcePlugins = {
          ripgrep.enable = true;
          spell.enable = true;
        };
      };
    };

    telescope.enable = true;
    minimap.codewindow.enable = true;

    utility = {
      outline = {
        aerial-nvim.enable = true;
      };
      preview = {
        glow.enable = true;
      };
    };

    # autocmd to disable autoformat via conform-nvim.
    # It is triggered opening terraform files if
    # conform-nvim has a corresponding Lua function
    # that defines the options listed here.
    # See formatter.nix > conform-nvim > setupOpts >
    # format_on_save
    # Refs:
    # - https://www.lazyvim.org/configuration/tips#disable-autoformat-for-some-buffers
    # - https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setupopts > format_on_save
    # - https://github.com/stevearc/conform.nvim/issues/192#issuecomment-2573170631
    autocmds = [
      {
        desc = "disable Terraform autoformat";
        enable =
          if terraformAutoformat
          then false
          else true;
        event = ["FileType"];
        pattern = ["terraform" "terraform-vars"];
        callback = lib.generators.mkLuaInline ''
          function()
            -- print("Terraform: autoformat disabled")
            vim.b.disable_autoformat=true
          end
        '';
      }
    ];

    formatter = import ./formatter.nix {
      inherit pkgs;
      inherit lib;
    };

    languages = {
      lua = {
        enable = true;
        treesitter.enable = true;
        lsp.enable = true;
      };

      helm = {
        enable = true;
        treesitter.enable = true;
        lsp = {
          enable = true;
        };
      };

      go = {
        enable = true;
        format.enable = true;
        treesitter.enable = true;
        lsp.enable = true;
      };

      python = {
        enable = true;
        format = {
          enable = true;
          type = ["ruff"];
        };
        treesitter.enable = true;
        lsp = {
          enable = true;
        };
      };

      terraform = {
        enable = true;
        treesitter.enable = true;
        lsp = {
          enable = true;
        };
      };
    };

    lsp = import ./lsp.nix {
      inherit pkgs;
      inherit lib;
    };

    extraPackages = with pkgs; [
      # go
      go
      gopls
      delve
      golangci-lint

      # python
      ruff

      # terraform
      nixpkgs-terraform.packages.${system}."terraform-${terraformVersion}"
    ];
  };
}

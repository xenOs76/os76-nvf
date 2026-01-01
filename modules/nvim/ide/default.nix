{
  pkgs,
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
    # extraLuaFiles = [
    #   ./lua/blink-cmp.lua
    # ];

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
            default = ["lsp" "path" "snippets" "buffer" "snippets" "ripgrep"];
          };

          cmdline = {
            keymap = {
              preset = "default";
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

    formatter = import ./formatter.nix {
      inherit pkgs;
      inherit lib;
    };

    languages = {
      lua.enable = true;
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
        format.enable = true;
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
    ];
  };
}

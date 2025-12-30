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

    # spellcheck = {
    #   enable = lib.mkForce true;
    #   programmingWordlist.enable = true;
    # };

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

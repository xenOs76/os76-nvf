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

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    autocomplete.nvim-cmp.enable = true;
    snippets.luasnip.enable = true;
    diagnostics.enable = true;
    notify.nvim-notify.enable = true;
    treesitter.enable = true;
    filetree.neo-tree.enable = true;
    fzf-lua.enable = true;

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

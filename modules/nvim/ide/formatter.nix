{
  pkgs,
  lib,
  ...
}: {
  conform-nvim = {
    enable = true;
    setupOpts = {
      format_on_save = lib.generators.mkLuaInline ''
        function(bufnr)
            -- Check global or buffer-local variable
            -- if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            if vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
      '';
      formatters = with pkgs; {
        goimports = {
          command = "${pkgs.gotools}/bin/goimports";
        };
        gofumpt = {
          command = "${lib.getExe gofumpt}";
        };
        markdownlint-cli2 = {
          command = "${lib.getExe markdownlint-cli2}";
        };
        nixfmt = {
          command = "${lib.getExe nixfmt}";
        };
        fixjson = {
          command = "${lib.getExe fixjson}";
        };
        stylua = {
          command = "${lib.getExe stylua}";
        };
        shellcheck = {
          command = "${lib.getExe shellcheck}";
        };
        shfmt = {
          command = "${lib.getExe shfmt}";
        };
        nginxfmt = {
          command = "${lib.getExe nginx-config-formatter}";
        };
      };

      formatters_by_ft = {
        lua = ["stylua"];
        nix = ["nixfmt"];
        sh = ["shfmt"];
        json = ["fixjson"];
        markdown = [
          "markdownlint-cli2"
        ];
        nginx = ["nginxfmt"];
        go = [
          "goimports"
          "gofumpt"
        ];
      };
    };
  };
}

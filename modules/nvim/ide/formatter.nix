{pkgs, ...}: {
  conform-nvim = {
    enable = true;
    setupOpts = {
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
      formatters = with pkgs; {
        goimports = {
          command = "${pkgs.gotools}/bin/goimports";
        };
        gofumpt = {
          command = "${lib.getExe gofumpt}";
        };
        black = {
          command = "${lib.getExe black}";
        };
        markdownlint-cli2 = {
          command = "${lib.getExe markdownlint-cli2}";
        };
        isort = {
          command = "${lib.getExe isort}";
        };
        alejandra = {
          command = "${lib.getExe alejandra}";
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
        yamlfmt = {
          command = "${lib.getExe yamlfmt}";
        };
        nginxfmt = {
          command = "${lib.getExe nginx-config-formatter}";
        };
      };

      formatters_by_ft = {
        lua = ["stylua"];
        nix = ["alejandra"];
        python = [
          "black"
          "isort"
        ];
        sh = ["shfmt"];
        json = ["fixjson"];
        yaml = ["yamlfmt"];
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

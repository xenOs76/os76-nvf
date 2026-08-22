{
  pkgs,
  lib,
  ...
}: {
  conform-nvim = {
    enable = true;
    setupOpts = {
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
      formatters = with pkgs; {
        markdownlint-cli2 = {
          command = "${lib.getExe markdownlint-cli2}";
        };
        nixfmt = {
          command = "${lib.getExe nixfmt}";
        };
        fixjson = {
          command = "${lib.getExe fixjson}";
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
        nix = ["nixfmt"];
        sh = ["shfmt"];
        json = ["fixjson"];
        # yaml = ["yamlfmt"]; # minimal only
        markdown = ["markdownlint-cli2"];
        nginx = ["nginxfmt"];
      };
    };
  };
}

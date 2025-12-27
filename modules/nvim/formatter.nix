{pkgs, ...}: {
  # TODO: add to ide and convert this to minimal
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
        alejandra = {
          command = "${lib.getExe alejandra}";
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
        yamlfmt = {
          command = "${lib.getExe yamlfmt}";
          # https://github.com/google/yamlfmt/blob/main/docs/command-usage.md#configuration-flags
          # https://github.com/google/yamlfmt/blob/main/docs/config-file.md#basic-formatter
          #args = ["-formatter" "indent=2,include_document_start=true,retain_line_breaks_single=true"];
        };
        nginxfmt = {
          command = "${lib.getExe nginx-config-formatter}";
        };
      };

      formatters_by_ft = {
        nix = ["alejandra"];
        sh = ["shfmt"];
        json = ["fixjson"];
        yaml = ["yamlfmt"];
        markdown = [
          "markdownlint-cli2"
        ];
        nginx = ["nginxfmt"];
      };
    };
  };
}

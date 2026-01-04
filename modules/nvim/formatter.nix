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
        nginxfmt = {
          command = "${lib.getExe nginx-config-formatter}";
        };
        # terraform_fmt = {
        #   command = "${lib.getExe opentofu}";
        # };
      };

      formatters_by_ft = {
        nix = ["alejandra"];
        sh = ["shfmt"];
        json = ["fixjson"];
        # yaml = ["yamlfmt"]; # minimal only
        markdown = ["markdownlint-cli2"];
        nginx = ["nginxfmt"];
        #terraform = ["terraform_fmt"];
      };
    };
  };
}

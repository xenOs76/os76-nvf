{pkgs, ...}: {
  vim = {
    dashboard.startify = {
      customFooter = [
        " Os76-Nvf - Minimal config "
      ];
    };

    formatter.conform-nvim = {
      setupOpts = {
        formatters = with pkgs; {
          yamlfmt = {
            command = "${lib.getExe yamlfmt}";
            # https://github.com/google/yamlfmt/blob/main/docs/command-usage.md#configuration-flags
            # https://github.com/google/yamlfmt/blob/main/docs/config-file.md#basic-formatter
            #args = ["-formatter" "indent=2,include_document_start=true,retain_line_breaks_single=true"];
          };
          terraform_fmt = {
            command = "${lib.getExe opentofu}";
          };
          ruff_format = {
            command = "${lib.getExe ruff}";
          };
        };

        formatters_by_ft = {
          yaml = ["yamlfmt"];
          terraform = ["terraform_fmt"];
          python = ["ruff_format"];
        };
      };
    };

    extraPackages = with pkgs; [
      # terraform
      opentofu

      # python
      ruff
    ];
  };
}

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
        };

        formatters_by_ft = {
          yaml = ["yamlfmt"];
        };
      };
    };
  };
}

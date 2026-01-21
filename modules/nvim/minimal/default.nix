{
  pkgs,
  lib,
  ...
}: {
  vim = {
    dashboard.startify = {
      customFooter = [
        " Os76-Nvf - Minimal config "
      ];
    };

    autocmds = [
      {
        desc = "Enable Neovim diagnostics";
        enable = true;
        event = ["FileType"];
        pattern = ["go" "terraform" "terraform-vars" "python"];
        callback = lib.generators.mkLuaInline ''
          function()
            -- print("Enable Neovim diagnostics")
            vim.diagnostic.config({ virtual_text = true })
          end
        '';
      }
    ];

    diagnostics = {
      nvim-lint = {
        enable = true;
        # https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
        linters_by_ft = {
          terraform = ["tflint"];
          go = ["golangcilint"];
          python = ["ruff"];
        };
        linters = {
          golangcilint = {
            cmd = lib.getExe pkgs.golangci-lint;
          };
          tflint = {
            cmd = lib.getExe pkgs.tflint;
          };
          ruff = {
            cmd = lib.getExe pkgs.ruff;
          };
        };
      };
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
      tflint

      # python
      ruff
    ];
  };
}

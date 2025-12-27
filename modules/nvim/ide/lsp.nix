{
  pkgs,
  lib,
  ...
}: {
  enable = true;
  inlayHints.enable = true;
  lspconfig.enable = true;
  servers = {
    # "*" = {
    #   root_markers = [".git"];
    #   capabilities = {
    #     textDocument = {
    #       semanticTokens = {
    #         multilineTokenSupport = true;
    #       };
    #     };
    #   };
    # };

    gopls = {
      enable = true;
      #cmd = lib.mkForce ["${pkgs.gopls}/bin/gopls"];
      # https://www.lazyvim.org/extras/lang/go#nvim-lspconfig
      settings = {
        gopls = {
          codelenses = {
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
          };

          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            functionTypeParameters = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };

          analyses = {
            assign = true;
            bools = true;
            composites = true;
            erroras = true;
            httpresponse = true;
            ifaceassert = true;
            loopclosure = true;
            lostcancel = true;
            nilfunc = true;
            nilness = true;
            printf = true;
            shadow = true;
            simplifycomposites = true;
            simplifyrange = true;
            simplifyslice = true;
            stdmethods = true;
            stringintconv = true;
            structtag = true;
            unmarshal = true;
            unreachable = true;
            unusedparams = true;
            unusedvariable = true;
            unusedwrite = true;
            useany = true;
          };

          gofumpt = true;
          matcher = "Fuzzy";
          semanticTokens = true;
          staticcheck = true;
          usePlaceholders = true;
          completeUnimported = true;
          completionDocumentation = true;

          directoryFilters = [
            "-.git"
            "-.vscode"
            "-.idea"
            "-.vscode-test"
            "-node_modules"
          ];
        };
      };
    };

    golangci_lint_ls = {
      enable = true;
      cmd = ["${pkgs.golangci-lint-langserver}/bin/golangci-lint-langserver"];
      settings = {
        init_options = {
          command = [
            "${lib.getExe pkgs.golangci-lint}"
            "run"
            "--output.json.path"
            "stdout"
            "--show-stats=false"
            "--issues-exit-code=1"
          ];
        };
      };
    };
  };
}

{
  lib,
  config,
  ...
}: {
  enable = true;
  inlayHints.enable = true;
  trouble = {enable = true;};
  lspconfig.enable = true;
  servers = {
    # TODO: systemd_ls
    "*" = {
      root_markers = [".git"];
      capabilities = {
        textDocument = {
          semanticTokens = {
            multilineTokenSupport = true;
          };
        };
      };
    };
    # https://github.com/redhat-developer/yaml-language-server
    # https://www.schemastore.org/
    # https://github.com/b0o/SchemaStore.nvim
    "yaml-language-server" = {
      root_markers = [".git"];
      capabilities = {
        textDocument = {
          semanticTokens = {
            multilineTokenSupport = true;
          };
        };
      };
      #cmd = ["${lib.getExe pkgs.yaml-language-server}" "--stdio"];
      filetypes = ["yaml"];
      settings = {
        redhat = {
          telemetry = {
            enabled = false;
          };
        };
        yaml = {
          keyOrdering = false;
          validate = true;
          format.enable = true;
          schemaStore = {
            # -- Must disable built-in schemaStore support to use
            # -- schemas from SchemaStore.nvim plugin
            enable = false;
            url = "";
          };
          schemas = lib.generators.mkLuaInline config.os76NvfCfg.yamlSchemastoreSchemas;
        };

        nixd = {
          enable = true;
          # cmd = lib.mkForce ["${pkgs.nixd}/bin/nixd"];
          filetypes = ["nix"];
          rootMarkers = [
            "flake.nix"
            ".git"
          ];
          settings = {};
        };
      };
    };
  };
}

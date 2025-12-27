{
  pkgs,
  lib,
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
          schemas = lib.generators.mkLuaInline ''
            require("schemastore").yaml.schemas({
                -- TODO: add additional schemas in the following section
                extra = {

                  {
                    description = "Ansible-lint JSON schema",
                    fileMatch = {"./inventory/*.yaml", "hosts.yml" },
                    name = 'hosts.yml',
                    url = "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json",
                  },

                  {
                    description = "HTTPS-Wrench JSON schema",
                    fileMatch = "https-wrench*.yaml",
                    name = "https-wrench.schema.json",
                    url = "https://raw.githubusercontent.com/xenOs76/https-wrench/refs/heads/main/https-wrench.schema.json",
                  },

                },
              })
          '';
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

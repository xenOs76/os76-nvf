{pkgs, ...}: {
  # https://github.com/qvalentin/helm-ls.nvim
  helm-ls-nvim = {
    package = pkgs.vimPlugins.helm-ls-nvim;
    setup = ''
      require('helm-ls').setup(
        {
          conceal_templates = {
            -- enable the replacement of templates with virtual text of their current values
            enabled = true, -- this might change to false in the future
          },
          indent_hints = {
            -- enable hints for indent and nindent functions
            enabled = true,
            -- show the hints only for the line the cursor is on
            only_for_current_line = false,
          },
          action_highlight = {
            -- enable highlighting of the current block
            enabled = true,
          },
        }
      )
    '';
  };

  # https://www.arthurkoziel.com/json-schemas-in-neovim/
  # yaml-companion = {
  #   package = pkgs.vimPlugins.yaml-companion-nvim;
  #   setup = ''
  #     local cfg = require("yaml-companion").setup {
  #       -- detect k8s schemas based on file content
  #       builtin_matchers = {
  #         kubernetes = { enabled = true }
  #       },
  #
  #       -- schemas available in Telescope picker
  #       schemas = {
  #         -- not loaded automatically, manually select with
  #         -- :Telescope yaml_schema
  #         {
  #           name = "Argo CD Application",
  #           uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
  #         },
  #         {
  #           name = "SealedSecret",
  #           uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json"
  #         },
  #         -- schemas below are automatically loaded, but added
  #         -- them here so that they show up in the statusline
  #         {
  #           name = "Kustomization",
  #           uri = "https://json.schemastore.org/kustomization.json"
  #         },
  #         {
  #           name = "GitHub Workflow",
  #           uri = "https://json.schemastore.org/github-workflow.json"
  #         },
  #         {
  #           name = "Istio VirtualService v1",
  #           uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/networking.istio.io/virtualservice_v1.json"
  #         },
  #       },
  #
  #       lspconfig = {
  #         settings = {
  #           yaml = {
  #             validate = true,
  #             schemaStore = {
  #               enable = false,
  #               url = ""
  #             },
  #
  #             -- schemas from store, matched by filename
  #             -- loaded automatically
  #             schemas = require('schemastore').yaml.schemas {
  #               select = {
  #                 'kustomization.yaml',
  #                 'GitHub Workflow',
  #               }
  #             }
  #           }
  #         }
  #       }
  #     }
  #
  #     require("lspconfig")["yamlls"].setup(cfg)
  #
  #     require("telescope").load_extension("yaml_schema")
  #
  #     -- get schema for current buffer
  #     local function get_schema()
  #       local schema = require("yaml-companion").get_buf_schema(0)
  #       if schema.result[1].name == "none" then
  #         return ""
  #       end
  #       return schema.result[1].name
  #     end
  #
  #     require('lualine').setup {
  #       sections = {
  #         lualine_x = {'fileformat', 'filetype', get_schema}
  #       }
  #     }
  #
  #   '';
  # };
}

{
  pkgs,
  lib,
  config,
  gitlineage-repo,
  ...
}: {
  options = {
    os76NvfCfg = {
      terraformAutoformat = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Conform.nvim to autoformat Terraform and Terraform-vars files";
        example = false;
      };

      yamlAutoformat = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Conform.nvim to autoformat Yaml files";
        example = false;
      };

      yamlExtraSchemas = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            name = lib.mkOption {type = lib.types.str;};
            description = lib.mkOption {type = lib.types.str;};
            url = lib.mkOption {type = lib.types.str;};
            fileMatch = lib.mkOption {type = lib.types.either lib.types.str (lib.types.listOf lib.types.str);};
          };
        });
        description = "List of extra JSON schemas for YAML validation";
        default = [
          {
            name = "Ansible-lint";
            description = "Ansible-lint JSON schema";
            url = "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json";
            fileMatch = ["./inventory/*.yaml" "hosts.yml"];
          }
          {
            name = "https-wrench";
            description = "HTTPS-Wrench JSON schema";
            url = "https://raw.githubusercontent.com/xenOs76/https-wrench/refs/heads/main/https-wrench.schema.json";
            fileMatch = ["https-wrench*.yaml" "https-wrench*.yml"];
          }
          {
            name = "Github Workflow";
            description = "Github Workflow JSON schema";
            url = "https://www.schemastore.org/github-workflow.json";
            fileMatch = ["**/.github/workflows/*.yml" "**/.github/workflows/*.yaml" "**/.gitea/workflows/*.yml" "**/.gitea/workflows/*.yaml"];
          }
          {
            name = "Istio Telemetry";
            description = "Istio Telemetry JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/telemetry.istio.io/telemetry_v1.json";
            fileMatch = ["*istio-telemetry.yaml" "istio-telemetry*.yaml"];
          }
          {
            name = "Istio Gateway";
            description = "Istio Gateway JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/networking.istio.io/gateway_v1.json";
            fileMatch = ["*istio-gateway.yaml" "istio-gateway*.yaml"];
          }
          {
            name = "Istio VirtualService";
            description = "Istio VirtualService JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/networking.istio.io/virtualservice_v1.json";
            fileMatch = ["*istio-virtualservice.yaml" "*virtualService.yaml" "*virtualservice.yaml"];
          }
          {
            name = "Istio EnvoyFilter";
            description = "Istio EnvoyFilter JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/networking.istio.io/envoyfilter_v1alpha3.json";
            fileMatch = ["*istio-envoyfilter.yaml" "envoyfilter-*.yaml"];
          }
          {
            name = "Prometheus ScrapeConfig";
            description = "Prometheus ScrapeConfig JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/scrapeconfig_v1alpha1.json";
            fileMatch = ["*scrapeconfig.yaml" "ScrapeConfig*.yaml"];
          }
          {
            name = "Prometheus Rule";
            description = "Prometheus Rule JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/prometheusrule_v1.json";
            fileMatch = ["*prometheusrule.yaml" "os76-prometheus-resources/templates/*rules.yaml"];
          }
          {
            name = "Kyverno ValidatingPolicy";
            description = "Kyverno ValidatingPolicy JSON schema";
            url = "https://raw.githubusercontent.com/xenOs76/os76-nvf/refs/heads/main/files/CRDs-schemas/kyverno/policies.kyverno.io/validatingpolicy_v1.json";
            fileMatch = ["*kyverno-validatingpolicy.yaml"];
          }
          {
            name = "Argo WorkflowTemplate";
            description = "Argo WorkflowTemplate JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/workflowtemplate_v1alpha1.json";
            fileMatch = ["*argo-workflowtemplate.yaml"];
          }
          {
            name = "Argo ApplicationSet";
            description = "Argo ApplicationSet JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/applicationset_v1alpha1.json";
            fileMatch = ["*argo-applicationset.yaml"];
          }
          {
            name = "Argo Application";
            description = "Argo Application JSON schema";
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/application_v1alpha1.json";
            fileMatch = ["*argo-application.yaml"];
          }
        ];
      };

      yamlSchemastoreSchemas = lib.mkOption {
        type = lib.types.str;
        description = "Lua expression that returns the YAML schemas table used by the language server via the Schemastore plugin";
        default = let
          extraItems =
            map (s: ''
              {
                description = ${lib.generators.toLua {} s.description},
                fileMatch = ${lib.generators.toLua {} s.fileMatch},
                name = ${lib.generators.toLua {} s.name},
                url = ${lib.generators.toLua {} s.url},
              },
            '')
            config.os76NvfCfg.yamlExtraSchemas;
        in ''
          require("schemastore").yaml.schemas({
            extra = {
              ${lib.concatStringsSep "\n" extraItems}
            },
          })
        '';
      };
    };
  };

  config = {
    vim = {
      viAlias = true;
      vimAlias = false;

      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
      };

      luaConfigPre = ''
        -- https://neovim.io/doc/user/lua.html#vim.filetype.add()
         vim.filetype.add({
           extension = {
             tfvars = "terraform-vars",
             tofu = "opentofu",
           },

           -- filename = {
           --  ["Jenkinsfile"] = "groovy",
           -- },

           pattern = {
             [".*/etc/nginx/.*%.conf"] = "nginx",

             -- https://zed.dev/docs/languages/helm
             ["**/templates/**/*.tpl"] = "helm",
             ["**/templates/**/*.yaml"] = "helm",
             ["**/templates/**/*.yml"] = "helm",
             ["**/helmfile.d/**/*.yaml"] = "helm",
             ["**/helmfile.d/**/*.yml"] = "helm",
             ["**/values*.yaml"] = "helm",
           },
         })

        -- split window border
        --
        -- https://www.reddit.com/r/neovim/comments/1dtcplk/winseparator_and_vertsplit/
        -- https://github.com/catppuccin/nvim/discussions/676
        -- https://catppuccin.com/palette/
        --
        -- vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#40a02b'})
        -- or
        require("catppuccin").setup {
            custom_highlights = function(colors)
                return {
                    WinSeparator = { fg = colors.mauve },
                }
            end
        }
      '';

      options = {
        cursorline = true;
        cursorlineopt = "number";
        expandtab = true;
        foldenable = false;
        mouse = "a";
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        winborder = "rounded";
        wrap = false;
      };

      autocmds = [
        {
          desc = "Enable Neovim diagnostics virtual_text for shell files";
          enable = true;
          event = ["BufEnter" "BufWinEnter"];
          pattern = ["*.sh"];
          callback = lib.generators.mkLuaInline ''
            function()
              vim.diagnostic.config({ virtual_text = true })
            end
          '';
        }
        {
          desc = "Disable Neovim diagnostics virtual_text when leaving shell files";
          enable = true;
          event = ["BufLeave"];
          pattern = ["*.sh"];
          callback = lib.generators.mkLuaInline ''
            function()
              vim.diagnostic.config({ virtual_text = false })
            end
          '';
        }
      ];

      undoFile.enable = true;
      clipboard.enable = true;
      spellcheck.enable = false;

      keymaps = import ./keymaps.nix;
      binds.whichKey.enable = true;

      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      autopairs.nvim-autopairs.enable = true;

      ui = import ./ui.nix;
      visuals = import ./visuals.nix;
      utility = import ./utility.nix;

      mini = {
        # https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-ai.md
        ai.enable = true;

        animate.enable = true;
        icons.enable = true;

        # https://github.com/nvim-mini/mini.surround
        surround = {
          enable = true;
          setupOpts = {
            mappings = {
              add = "sa"; #-- Add surrounding in Normal and Visual modes
              delete = "sd"; # -- Delete surrounding
              find = "sf"; # -- Find surrounding (to the right)
              find_left = "sF"; #  -- Find surrounding (to the left)
              highlight = "sh"; # -- Highlight surrounding
              replace = "sr"; # -- Replace surrounding

              suffix_last = "l"; # -- Suffix to search with "prev" method
              suffix_next = "n"; # -- Suffix to search with "next" method
            };
          };
        };
      };

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      autocomplete = {
        enableSharedCmpSources = true;
        nvim-cmp = {
          enable = true;
          sources = {
            buffer = "[Buffer]";
            path = "[Path]";
          };
        };
      };

      snippets.luasnip.enable = true;
      notify.nvim-notify.enable = true;
      filetree.neo-tree.enable = true;
      fzf-lua.enable = true;

      diagnostics = {
        enable = true;
        config = {
          # disabled: see tiny-inline-diagnostic for more
          underline = false;
          virtual_lines = false;
          virtual_text = false;
        };

        nvim-lint = {
          enable = true;
          # https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
          linters_by_ft = {
            yaml = ["yamllint"];
            # tofu-ls validateOnSave is stubbed upstream; tofu_validate fills the gap.
            terraform = ["tflint" "tofu_validate"];
            terraform-vars = ["tofu_validate"];
            opentofu = ["tflint" "tofu_validate"];
            sh = ["shellcheck"];
            go = ["golangcilint"];
          };
          linters = {
            golangcilint = {
              cmd = lib.getExe pkgs.golangci-lint;
            };
            # Stock nvim-lint uses --recursive (full-repo fan-out). Lint one module only.
            tflint = {
              cmd = lib.getExe pkgs.tflint;
              args = ["--format=json" "--no-parallel-runners"];
              parser = lib.generators.mkLuaInline ''
                function(output, bufnr, linter_cwd)
                  local severity_map = {
                    warning = vim.diagnostic.severity.WARN,
                    error = vim.diagnostic.severity.ERROR,
                    notice = vim.diagnostic.severity.INFO,
                  }
                  local decoded = vim.json.decode(output) or {}
                  local issues = decoded["issues"] or {}
                  local diagnostics = {}
                  local buf_abs = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))

                  for _, issue in ipairs(issues) do
                    local issue_path = issue.range.filename
                    if not vim.startswith(issue_path, "/") then
                      issue_path = vim.fs.joinpath(linter_cwd or "", issue_path)
                    end
                    if vim.fs.normalize(issue_path) == buf_abs then
                      table.insert(diagnostics, {
                        lnum = assert(tonumber(issue.range.start.line)) - 1,
                        end_lnum = assert(tonumber(issue.range["end"].line)) - 1,
                        col = assert(tonumber(issue.range.start.column)) - 1,
                        end_col = assert(tonumber(issue.range["end"].column)) - 1,
                        severity = severity_map[issue.rule.severity],
                        source = "tflint",
                        message = string.format(
                          "%s (%s)\nReference: %s",
                          issue.message,
                          issue.rule.name,
                          issue.rule.link
                        ),
                      })
                    end
                  end
                  return diagnostics
                end
              '';
            };
            # Shell out to `tofu validate -json` — tofu-ls/terraform-ls validate is a no-op.
            # Module-wide: errors in *other* .tf files still appear on the buffer you saved
            # (prefixed with filename), matching CLI `tofu validate` visibility.
            tofu_validate = {
              cmd = lib.getExe pkgs.opentofu;
              args = ["validate" "-json"];
              append_fname = false;
              stdin = false;
              stream = "stdout";
              ignore_exitcode = true;
              parser = lib.generators.mkLuaInline ''
                function(output, bufnr, linter_cwd)
                  local severity_map = {
                    warning = vim.diagnostic.severity.WARN,
                    error = vim.diagnostic.severity.ERROR,
                    notice = vim.diagnostic.severity.INFO,
                  }
                  local ok, decoded = pcall(vim.json.decode, output)
                  if not ok or type(decoded) ~= "table" then
                    return {}
                  end

                  local buf_abs = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
                  local buf_name = vim.fn.fnamemodify(buf_abs, ":t")
                  local cwd = linter_cwd or vim.fn.getcwd()
                  local current = {}
                  local by_abs = {}

                  local function abs_path(rel)
                    if vim.startswith(rel, "/") then
                      return vim.fs.normalize(rel)
                    end
                    return vim.fs.normalize(vim.fs.joinpath(cwd, rel))
                  end

                  for _, d in ipairs(decoded.diagnostics or {}) do
                    local message = d.summary or "validate error"
                    if d.detail and d.detail ~= "" then
                      message = message .. " — " .. d.detail
                    end
                    local severity = severity_map[d.severity] or vim.diagnostic.severity.ERROR

                    if d.range == nil then
                      table.insert(current, {
                        lnum = 0,
                        col = 0,
                        severity = severity,
                        source = "tofu validate",
                        message = message,
                      })
                    else
                      local issue_abs = abs_path(d.range.filename)
                      local issue_name = vim.fn.fnamemodify(issue_abs, ":t")
                      local diag = {
                        lnum = assert(tonumber(d.range.start.line)) - 1,
                        end_lnum = assert(tonumber(d.range["end"].line)) - 1,
                        col = assert(tonumber(d.range.start.column)) - 1,
                        end_col = assert(tonumber(d.range["end"].column)) - 1,
                        severity = severity,
                        source = "tofu validate",
                        message = message,
                      }
                      local on_current = issue_abs == buf_abs or issue_name == buf_name
                      if on_current then
                        table.insert(current, diag)
                      else
                        table.insert(current, {
                          lnum = 0,
                          col = 0,
                          severity = severity,
                          source = "tofu validate",
                          message = string.format(
                            "[%s:%d] %s",
                            issue_name,
                            diag.lnum + 1,
                            message
                          ),
                        })
                        by_abs[issue_abs] = by_abs[issue_abs] or {}
                        table.insert(by_abs[issue_abs], diag)
                      end
                    end
                  end

                  -- Mirror into other loaded buffers so navigating there keeps locations.
                  local ns = require("lint").get_namespace("tofu_validate")
                  for _, b in ipairs(vim.api.nvim_list_bufs()) do
                    if b ~= bufnr and vim.api.nvim_buf_is_loaded(b) then
                      local name = vim.api.nvim_buf_get_name(b)
                      if name ~= "" then
                        local other = by_abs[vim.fs.normalize(name)]
                        vim.diagnostic.set(ns, b, other or {})
                      end
                    end
                  end

                  return current
                end
              '';
            };
            yamllint = {
              cmd = lib.getExe pkgs.yamllint;
            };
            shellcheck = {
              cmd = lib.getExe pkgs.shellcheck;
            };
          };
          # tflint / tofu_validate: cwd = buffer dir (module under edit)
          lint_function = lib.generators.mkLuaInline ''
            function(buf)
              local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
              local linters = require("lint").linters
              local linters_from_ft = require("lint").linters_by_ft[ft]
              if linters_from_ft == nil then return end

              for _, name in ipairs(linters_from_ft) do
                local linter = linters[name]
                assert(linter, "Linter with name `" .. name .. "` not available")
                if type(linter) == "function" then
                  linter = linter()
                end
                linter.name = linter.name or name

                local opts = {}
                if name == "tflint" or name == "tofu_validate" then
                  local path = vim.api.nvim_buf_get_name(buf)
                  if path ~= "" then
                    opts.cwd = vim.fn.fnamemodify(path, ":h")
                  end
                end

                local required = linter.required_files
                if required == nil then
                  require("lint").lint(linter, opts)
                else
                  for _, fn in ipairs(required) do
                    local cfg_path = vim.fs.joinpath(opts.cwd or linter.cwd or vim.fn.getcwd(), fn)
                    if vim.uv.fs_stat(cfg_path) then
                      require("lint").lint(linter, opts)
                      break
                    end
                  end
                end
              end
            end
          '';
        };
      };

      treesitter = {
        enable = true;
        fold = true;
        indent.enable = true;

        # https://github.com/nvim-treesitter/nvim-treesitter-context
        context.enable = true;

        # https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        textobjects = {enable = true;};

        # Prefer Neovim 0.12 built-in incremental selection: Visual `an` / `in`
        # (treesitter nodes; also LSP selectionRange where the server supports it).
        # Do not re-enable nvim-treesitter incrementalSelection mappings.
        # https://neovim.io/doc/user/news-0.12.html
        mappings = {
          # incrementalSelection = {
          #   init = "<Enter>";
          #   decrementByNode = "<Backspace>";
          #   incrementByNode = "<Enter>";
          #   incrementByScope = "grc";
          # };
        };

        # https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          awk
          bash
          caddy
          comment
          dockerfile
          editorconfig
          # fluentbit  # not packaged
          git_config
          git_rebase
          # git_commit # not packaged
          gitcommit
          gitattributes
          gitignore
          go
          gotmpl
          gosum
          gomod
          gowork
          gpg
          hcl
          helm
          ini
          jinja
          jinja_inline
          jq
          json
          # json_schema # not packaged
          lua
          make
          mermaid
          nginx
          nix
          passwd
          pem
          promql
          regex
          ssh_config
          terraform
          toml
          udev
          vhs
          vim
          xml
          # xquery # not packaged
          yaml
          zsh
        ];
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
        neogit.enable = false;
      };

      formatter = import ./formatter.nix {
        inherit pkgs;
        inherit lib;
      };

      lsp = import ./lsp.nix {
        inherit pkgs;
        inherit lib;
        inherit config;
      };

      languages = import ./languages.nix;

      extraPlugins = import ./extra-plugins.nix {
        inherit pkgs;
        inherit gitlineage-repo;
      };

      extraPackages = with pkgs; [
        ripgrep
        fzf
        lazygit

        # yaml
        vimPlugins.SchemaStore-nvim
      ];

      dashboard.startify = {
        enable = true;
        customHeader = [
          ""
          "     ooooooo              ooooooooooo  ooooooo           oooo   oooo              o888o "
          "   o888   888o  oooooooo8 888    888 o88                  8888o  88 oooo   oooo o888oo  "
          "   888     888 888ooooooo       888  888888888o ooooooooo 88 888o88  888   888   888    "
          "   888o   o888         888     888   88o    o888          88   8888   888 888    888    "
          "     88ooo88   88oooooo88     888      88ooo88           o88o    88     888     o888o   "
          "                                                                                     "
          "      https://github.com/xenos76/os76-nvf "
          ""
        ];
      };
    };
  };
}

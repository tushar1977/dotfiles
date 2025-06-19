return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = {
          severity = vim.diagnostic.severity.ERROR,
        },
        signs = {
          severity = vim.diagnostic.severity.ERROR,
        },
        underline = {
          severity = vim.diagnostic.severity.ERROR,
        },
      })
      local configs = require("lspconfig.configs")
      if not configs.protobuf_language_server then
        configs.protobuf_language_server = {
          default_config = {
            cmd = { vim.fn.expand("$HOME/go/bin/protobuf-language-server") },
            filetypes = { "proto", "cpp" },
            root_dir = require("lspconfig.util").root_pattern(".git", "."),
            single_file_support = true,
            settings = {
              ["additional-proto-dirs"] = {},
            },
          },
        }
      end
      -- Ensure snippet support
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- Add ls_emmet config if it doesn't exist
      if not configs.ls_emmet then
        configs.ls_emmet = {
          default_config = {
            cmd = { "ls_emmet", "--stdio" },
            filetypes = {
              "html",
              "css",
              "scss",
              "javascriptreact",
              "typescriptreact",
              "haml",
              "xml",
              "xsl",
              "pug",
              "slim",
              "sass",
              "stylus",
              "less",
              "sss",
              "hbs",
              "handlebars",
            },
            root_dir = function(fname)
              return vim.loop.cwd()
            end,
            settings = {},
          },
        }
      end
      -- Setup ls_emmet with capabilities
      lspconfig.ls_emmet.setup({
        capabilities = capabilities,
      })
      opts.servers = opts.servers or {}
      -- Add servers
      opts.servers.rust_analyzer = {}
      opts.servers.gdscript = {}
      opts.servers.clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp" },
      }
      opts.servers.protobuf_language_server = {}
      opts.servers.tsserver = {}
      opts.servers.vtsls = { enabled = false, mason = false }
      opts.servers.pyright = {
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/pyright-langserver"), "--stdio" },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
        autostart = true,
      }

      opts.setup = opts.setup or {}
      opts.setup.gdscript = function(_, server_opts)
        lspconfig["gdscript"].setup({
          name = "godot",
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
          root_dir = server_opts.root_dir,
          capabilities = server_opts.capabilities,
        })
        return true
      end
      opts.setup.protobuf_language_server = function(_, server_opts)
        require("lspconfig").protobuf_language_server.setup(server_opts)
        return true
      end
      opts.setup.tsserver = function(_, server_opts)
        require("typescript").setup({
          server = server_opts,
          init_options = {
            preferences = {
              disableSuggestions = true,
              includeInlayParameterNameHints = "none",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = false,
              includeInlayEnumMemberValueHints = false,
            },
          },
        })
        return true
      end
      opts.setup.eslint = function(_, _)
        lspconfig.eslint.setup({
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        })
        return true
      end

      return opts
    end,
  },
}

-- Machines without Node.js: disable npm-based servers/tools instead of letting them crash.
if vim.fn.executable("node") == 1 then
  return {}
end

local npm_tools = {
  prettier = true,
  ["markdownlint-cli2"] = true,
  ["markdown-toc"] = true,
  ["js-debug-adapter"] = true,
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = { enabled = false },
        jsonls = { enabled = false },
        ansiblels = { enabled = false },
        vtsls = { enabled = false },
        copilot = { enabled = false },
        helm_ls = { settings = { ["helm-ls"] = { yamlls = { enabled = false } } } },
      },
    },
  },
  -- sidekick NES needs copilot-language-server; the CLI/terminal part keeps working
  {
    "folke/sidekick.nvim",
    optional = true,
    opts = { nes = { enabled = false } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      for ft, linters in pairs(opts.linters_by_ft or {}) do
        opts.linters_by_ft[ft] = vim.tbl_filter(function(l)
          return not npm_tools[l]
        end, linters)
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not npm_tools[tool]
      end, opts.ensure_installed or {})
    end,
  },
}

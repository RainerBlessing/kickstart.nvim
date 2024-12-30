vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    local jdtls = require 'jdtls'
    local config = require 'custom.jdtls'
    jdtls.start_or_attach(config)
  end,
})

--require('lspconfig').pyright.setup {
--  settings = {
--    python = {
--      pythonPath = '.venv/bin/python',
--      venvPath = './',
--      venv = '.venv',
--      analysis = {
--        autoSearchPaths = true,
--        useLibraryCodeForTypes = true,
--        diagnosticMode = 'workspace',
--      },
--    },
--  },
--}
-- Set running linters on buffer save
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

-- Set pylint to work in virtualenv
require('lint').linters.pylint.cmd = 'python'
--require('lint').linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
require('lint').linters.pylint.args = {
  '-m',
  'pylint',
  '-f',
  'json',
  '--from-stdin',
  function()
    return vim.api.nvim_buf_get_name(0)
  end,
}

local venv = vim.fn.trim(vim.fn.system 'poetry env info --path')
require('lspconfig').pylsp.setup {
  cmd = { venv .. '/bin/pylsp' },
  settings = {
    pylsp = {
      plugins = {
        jedi = {
          environment = venv,
        },
      },
    },
  },
}
require('lspconfig').ruff_lsp.setup {
  cmd = { venv .. '/bin/ruff' },
}
require('lspconfig').null_ls.setup {
  sources = {
    require('null-ls').builtins.diagnostics.ruff.with {
      command = { venv .. '/bin/ruff' },
    },
    require('none-ls').builtins.diagnostics.ruff.with {
      command = { venv .. '/bin/ruff' },
    },
  },
}

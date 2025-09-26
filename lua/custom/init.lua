vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    local jdtls = require 'jdtls'
    local config = require 'custom.jdtls'
    jdtls.start_or_attach(config)
  end,
})

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

-- Python LSP-Konfiguration mit Poetry (wenn verfügbar)
local poetry_venv = vim.fn.system 'poetry env info --path 2>/dev/null'
if vim.v.shell_error == 0 and poetry_venv ~= '' then
  local venv = vim.fn.trim(poetry_venv)
  if vim.fn.isdirectory(venv) == 1 then
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
  else
    -- Fallback to system pylsp
    require('lspconfig').pylsp.setup {}
  end
else
  -- Fallback to system pylsp
  require('lspconfig').pylsp.setup {}
end

-- C++ LSP-Konfiguration für NixOS
require('lspconfig').clangd.setup {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_dir = function(fname)
    return require('lspconfig').util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git')(fname) or vim.fn.getcwd()
  end,
}

require('auto-create-directory').setup()

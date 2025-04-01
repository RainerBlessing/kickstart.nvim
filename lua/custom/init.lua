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

-- C++ LSP-Konfiguration für NixOS
require('lspconfig').clangd.setup {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_dir = function(fname)
    return require('lspconfig').util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git')(fname) or vim.fn.getcwd()
  end,
}

require('auto-create-directory').setup()

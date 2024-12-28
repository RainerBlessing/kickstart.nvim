vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    local jdtls = require 'jdtls'
    local config = require 'custom.jdtls'
    jdtls.start_or_attach(config)
  end,
})

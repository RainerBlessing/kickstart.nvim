return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rcasia/neotest-java', -- Java-Adapter
      'nvim-neotest/neotest-python', -- Python-Adapter
    },
    init = function()
      -- Key Mappings für neotest
      vim.api.nvim_set_keymap('n', '<leader>tf', ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>tn', ":lua require('neotest').run.run()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ts', ":lua require('neotest').summary.toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>to', ":lua require('neotest').output.open()<CR>", { noremap = true, silent = true })
    end,
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {

            dap = { justMyCode = false },
            runner = 'pytest',
          },
          require 'neotest-java' {
            runner = 'gradle',
            --log_level = vim.log.levels.DEBUG,
          },
        },
        --log_level = vim.log.levels.DEBUG
      }
    end,
  },
}

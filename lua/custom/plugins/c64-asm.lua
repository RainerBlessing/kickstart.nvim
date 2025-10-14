-- C64 Assembly development plugins
return {
  {
    -- ACME assembler syntax highlighting
    'leissa/vim-acme',
    ft = { 'acme', 'asm' },
    config = function()
      -- Set up file associations for ACME assembler files
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"*.asm", "*.a", "*.acme", "*.s"},
        callback = function()
          vim.bo.filetype = "acme"
        end,
      })

      -- Set up some useful keymaps for C64 development
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "acme",
        callback = function()
          local opts = { buffer = true, silent = true }

          -- Build and run with ACME + VICE
          vim.keymap.set('n', '<leader>cb', function()
            local file = vim.fn.expand('%:p')
            local output = vim.fn.expand('%:p:r') .. '.prg'
            local cmd = string.format('acme -f cbm -o "%s" "%s"', output, file)
            vim.cmd('split | terminal ' .. cmd)
          end, vim.tbl_extend('force', opts, { desc = '[C64] [B]uild with ACME' }))

          -- Run in VICE emulator
          vim.keymap.set('n', '<leader>cr', function()
            local output = vim.fn.expand('%:p:r') .. '.prg'
            if vim.fn.filereadable(output) == 1 then
              local cmd = string.format('x64sc "%s"', output)
              vim.fn.system(cmd .. ' &')
              print('Running in VICE: ' .. output)
            else
              print('No .prg file found. Build first with <leader>cb')
            end
          end, vim.tbl_extend('force', opts, { desc = '[C64] [R]un in VICE' }))

          -- Build and run in one go
          vim.keymap.set('n', '<leader>cR', function()
            local file = vim.fn.expand('%:p')
            local output = vim.fn.expand('%:p:r') .. '.prg'
            local build_cmd = string.format('acme -f cbm -o "%s" "%s"', output, file)
            local run_cmd = string.format('x64sc "%s"', output)

            -- Build first, then run if successful
            local result = vim.fn.system(build_cmd)
            if vim.v.shell_error == 0 then
              vim.fn.system(run_cmd .. ' &')
              print('Built and running in VICE: ' .. output)
            else
              print('Build failed: ' .. result)
            end
          end, vim.tbl_extend('force', opts, { desc = '[C64] Build and [R]un' }))
        end,
      })
    end,
  },
}
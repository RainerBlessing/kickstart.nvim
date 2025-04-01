return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        sections = {
          lualine_c = {
            { 'filename', path = 1 },
            -- path = 0 => nur Dateiname
            -- path = 1 => relativer Pfad
            -- path = 2 => absoluter Pfad
          },
        },
      }
    end,
  },
}

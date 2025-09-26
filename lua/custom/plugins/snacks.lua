-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Snacks.vim hinzufügen
return {
{
    "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Fix all dashboard highlights after setup
    vim.defer_fn(function()
      -- Clear all possible dashboard highlight backgrounds
      local highlights = {
        "SnacksDashboard",
        "SnacksDashboardNormal",
        "SnacksDashboardHeader",
        "SnacksDashboardFooter",
        "SnacksDashboardDesc",
        "SnacksDashboardKey",
        "SnacksDashboardIcon",
        "SnacksDashboardSpecial",
        "SnacksDashboardTitle",
        "SnacksDashboardGroup",
        "SnacksDashboardFile",
        "SnacksDashboardDir",
        "SnacksDashboardTerminal",
        "Normal",
        "NormalFloat",
        "FloatBorder",
      }

      for _, hl in ipairs(highlights) do
        local ok, existing = pcall(vim.api.nvim_get_hl, 0, { name = hl })
        if ok and existing then
          existing.bg = "none"
          existing.ctermbg = "none"
          vim.api.nvim_set_hl(0, hl, existing)
        end
      end

      -- Specific overrides for dashboard
      vim.cmd([[
        highlight clear SnacksDashboard
        highlight clear SnacksDashboardNormal
        highlight SnacksDashboard guibg=NONE ctermbg=NONE
        highlight SnacksDashboardNormal guibg=NONE ctermbg=NONE
      ]])
    end, 100)
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dashboard = {
      enabled = false,
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 0, padding = 0 },
        { section = "startup" },
      },
      formats = {
        header = { "%s", align = "center" },
      },
    },
  },
  },
}

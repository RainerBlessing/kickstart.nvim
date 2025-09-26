return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = 'ollama',
    auto_suggestions_provider = 'ollama',
    providers = {
      ollama = {
        endpoint = 'http://127.0.0.1:11434',
        model = 'incept5/llama3.1-claude:latest',
        timeout = 30000,
        extra_request_body = {
          options = {
            temperature = 0.75,
            num_ctx = 20480,
            keep_alive = '5m',
          },
        },
      },
      claude = {
        endpoint = os.getenv 'AVANTE_ANTHROPIC_ENDPOINT' or 'https://api.anthropic.com',
        model = 'claude-3-5-sonnet-20240620',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      openai = {
        endpoint = os.getenv 'AVANTE_OPENAI_ENDPOINT' or 'https://api.openai.com/v1',
        model = 'gpt-4o',
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}

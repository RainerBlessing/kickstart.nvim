-- mini.lua: Konfigurationsdatei für mini.nvim mit lazy.nvim

return {
  -- Hinzufügen von mini.nvim mit Lazy
  {
    'echasnovski/mini.nvim',
    version = '*', -- Automatisch die neueste Version verwenden
    config = function()
      -- Mini AI: Verbesserte Texterkennung für Textobjekte
      require('mini.ai').setup {
        -- Benutzerdefinierte Textobjekte hier hinzufügen
      }

      -- Mini Cursorword: Hebt das Wort unter dem Cursor hervor
      require('mini.cursorword').setup {
        delay = 100, -- Verzögerung für die Hervorhebung
      }

      -- Mini Indentscope: Zeigt den aktuellen Einrückungsbereich an
      require('mini.indentscope').setup {
        symbol = '│', -- Zeichen für die Darstellung der Einrückungen
        options = { border = 'both', try_as_border = true },
      }

      -- Mini Jump: Erweiterte Sprung-Funktionalität
      require('mini.jump').setup()

      -- Mini Pairs: Automatische Paare (z. B. Klammern)
      require('mini.pairs').setup()

      -- Mini Surround: Manipulation von Umgebungen (z. B. Klammern, Zitate)
      require('mini.surround').setup {
        -- Benutzerdefinierte Umgebungen hier hinzufügen
      }

      -- Mini Starter: Startbildschirm
      -- NOTE: clashes with snacks dashboard
      --require('mini.starter').setup {
      --  evaluate_single = true, -- Automatisches Starten bei einem Eintrag
      --}

      -- Mini Tabline: Minimalistische Tab-Linie
      require('mini.tabline').setup {
        show_icons = true, -- Zeige Puffer-Symbole
      }

      -- Mini Trailspace: Entfernung von überflüssigen Leerzeichen
      require('mini.trailspace').setup()

      require('mini.files').setup()
      require('mini.icons').setup()

      require('mini.ai').setup()
      vim.keymap.set('n', '-', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end)
    end,
  },
}

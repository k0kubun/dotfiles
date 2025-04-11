-- Register a custom provider that calls CocAction('doHover')
require('hover').register {
  name = 'coc.nvim',
  enabled = function()
    return true
  end,
  execute = function(_, done)
    --vim.cmd("call CocAction('doHover')")
    vim.cmd("call MouseHoverOnClick()")
    done(false) -- Prevent hover.nvim from showing a window
  end,
  priority = 9999
}

require('hover').setup {
  init = function()
    -- Optionally keep LSP or remove if you only use coc.nvim
    require('hover.providers.lsp')
  end,
  preview_opts = {
    border = 'single'
  },
  preview_window = false,
  title = true,
  mouse_providers = { 'coc.nvim' },
  mouse_delay = 100
}

-- Enable mouse hover event
vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
vim.o.mousemoveevent = true

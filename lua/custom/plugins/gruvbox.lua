return {
  {
    'morhetz/gruvbox',
    priority = 1000,
    config = function()
      -- If you want to use gruvbox, uncomment the line below
      vim.g.gruvbox_italicize_strings = 1
      vim.g.gruvbox_italicize_comments = 1
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.cmd.colorscheme 'gruvbox'

      -- Link Snacks picker highlights to standard highlights for gruvbox compatibility
      vim.api.nvim_set_hl(0, 'SnacksPickerNormal', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { link = 'FloatBorder' })
      vim.api.nvim_set_hl(0, 'SnacksPickerTitle', { link = 'FloatTitle' })
    end,
  },
}

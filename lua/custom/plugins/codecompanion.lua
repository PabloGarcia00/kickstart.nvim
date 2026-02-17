return {
  'olimorris/codecompanion.nvim',
  version = '^18.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    strategies = {
      chat = { adapter = 'gemini' },
      inline = { adapter = 'gemini' },
      agent = { adapter = 'gemini' },
    },
    adapters = {
      gemini = function()
        return require('codecompanion.adapters').extend('gemini', {
          schema = {
            model = {
              default = 'gemini-1.5-pro-exp-0827', -- Or your preferred model
            },
          },
        })
      end,
    },
  },
}

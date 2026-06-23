return {
  'frankroeder/parrot.nvim',
  dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
  config = function()
    require('parrot').setup {
      providers = {
        gemini = {
          name = 'gemini',
          api_key = os.getenv 'GEMINI_API_KEY',
          endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/',
          params = {
            chat = { temperature = 1.0, top_p = 1 },
            command = { temperature = 1.0, top_p = 1 },
          },
          topic = {
            model = 'gemini-2.0-flash',
            params = { maxOutputTokens = 64 },
          },
          models = {
            'gemini-2.5-pro',
            'gemini-2.5-flash',
            'gemini-2.0-flash',
          },
        },
        anthropic = {
          name = 'anthropic',
          api_key = os.getenv 'ANTHROPIC_API_KEY',
          endpoint = 'https://api.anthropic.com/v1/messages',
          params = {
            chat = { temperature = 1.0, top_p = 1, max_tokens = 4096 },
            command = { temperature = 1.0, top_p = 1, max_tokens = 4096 },
          },
          topic = {
            model = 'claude-haiku-4-5-20251001',
            params = { max_tokens = 64 },
          },
          models = {
            'claude-opus-4-8',
            'claude-sonnet-4-6',
            'claude-haiku-4-5-20251001',
          },
        },
        pplx = {
          name = 'pplx',
          api_key = os.getenv 'PERPLEXITY_API_KEY',
          endpoint = 'https://api.perplexity.ai/chat/completions',
          params = {
            chat = { temperature = 1.0, top_p = 1 },
            command = { temperature = 1.0, top_p = 1 },
          },
          topic = {
            model = 'sonar',
            params = { max_tokens = 64 },
          },
          models = {
            'sonar-pro',
            'sonar',
            'sonar-reasoning-pro',
          },
        },
      },
    }
  end,
  keys = {
    { '<leader>p', nil, desc = 'Parrot AI' },
    { '<leader>pc', '<cmd>PrtChatNew<cr>', desc = 'New chat' },
    { '<leader>pt', '<cmd>PrtChatToggle<cr>', desc = 'Toggle chat' },
    { '<leader>pf', '<cmd>PrtChatFinder<cr>', desc = 'Find chat' },
    { '<leader>pp', '<cmd>PrtProvider<cr>', desc = 'Switch provider' },
    { '<leader>pm', '<cmd>PrtModel<cr>', desc = 'Switch model' },
    { '<leader>pr', '<cmd>PrtRewrite<cr>', mode = { 'n', 'v' }, desc = 'Rewrite selection' },
    { '<leader>pa', '<cmd>PrtAppend<cr>', mode = { 'n', 'v' }, desc = 'Append after selection' },
    { '<leader>pi', '<cmd>PrtPrepend<cr>', mode = { 'n', 'v' }, desc = 'Prepend before selection' },
    { '<leader>ps', '<cmd>PrtChatPaste<cr>', mode = 'v', desc = 'Paste to chat' },
  },
}

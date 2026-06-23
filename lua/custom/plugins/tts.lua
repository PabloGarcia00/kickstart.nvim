return {
  'johannww/tts.nvim',
  cmd = { 'TTS', 'TTSFile', 'TTSSetLanguage', 'TTSSetBackend' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>ts', ':<C-u>\'<,\'>TTS<CR>', mode = 'v', desc = '[T]ext-to-[S]peech (selection)' },
    { '<leader>tf', ':<C-u>\'<,\'>TTSFile<CR>', mode = 'v', desc = '[T]TS save to [F]ile (selection)' },
  },
  opts = {
    backend = 'edge',
    language = 'en',
    speed = 1.0,
    -- Strip markup before speaking; "simple" uses regex and needs no extra deps
    remove_syntax = true,
    syntax_removal_method = 'simple',
    languages_to_voice = {
      edge = {
        ['en'] = 'en-GB-SoniaNeural',
        ['es'] = 'es-ES-ElviraNeural',
        ['fr'] = 'fr-FR-DeniseNeural',
        ['de'] = 'de-DE-KatjaNeural',
        ['it'] = 'it-IT-ElsaNeural',
        ['pt'] = 'pt-BR-AntonioNeural',
        ['ja'] = 'ja-JP-NanamiNeural',
        ['zh'] = 'zh-CN-XiaoxiaoNeural',
      },
    },
  },
}

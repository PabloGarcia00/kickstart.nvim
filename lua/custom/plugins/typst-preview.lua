return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {
    follow_cursor = true,
    dependencies_bin = {
      ['tynimist'] = 'tynimist',
    },
  },
}

return {
  'Vigemus/iron.nvim',
  event = 'VimEnter',
  opts = {
    config = {
      -- Whether a repl should be discarded or not
      scratch_repl = true,

      -- Your repl definitions
      repl_definition = {
        sh = {
          command = { 'zsh' },
        },
        python = {
          command = { 'ipython', '--no-autoindent' }, -- or { "ipython", "--no-autoindent" }
          -- NOTE: common is not directly available here.
          -- You will need to require it inside the setup function if you use a function
          -- OR ensure 'common' is available (LazyVim often loads all files in the
          -- plugin directory, but it's safer to ensure the require)
          format = require('iron.fts.common').bracketed_paste_python,
          block_dividers = { '# %%', '#%%' },
          env = { PYTHON_BASIC_REPL = '1' }, -- needed for python3.13 and up.
        },
        lua = {
          command = { 'lua' },
          block_dividers = { '-- %%', '--%%' },
        },
      },
      -- set the file type of the newly created repl to ft
      repl_filetype = function(bufnr, ft)
        return ft
      end,

      -- Send selections to the DAP repl if an nvim-dap session is running.
      dap_integration = true,

      -- How the repl window will be displayed

      repl_open_cmd = require('iron.view').split.vertical.botright '40%',
    },

    -- Iron doesn't set keymaps by default anymore.
    keymaps = {
      toggle_repl = '<space>rr', -- toggles the repl open and closed.
      restart_repl = '<space>rR', -- calls `IronRestart` to restart the repl
      send_motion = '<space>sc',
      visual_send = '<space>sc',
      send_file = '<space>sf',
      send_line = '<space>sl',
      send_paragraph = '<space>sp',
      send_until_cursor = '<space>su',
      send_mark = '<space>sm',
      send_code_block = '<space>sb',
      send_code_block_and_move = '<space>sn',
      mark_motion = '<space>mc',
      mark_visual = '<space>mc',
      remove_mark = '<space>md',
      cr = '<space>s<cr>',
      interrupt = '<space>s<space>',
      exit = '<space>sq',
      clear = '<space>cl',
    },

    -- If the highlight is on, you can change how it looks
    highlight = {
      italic = true,
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
  },

  -- Keymaps that call specific Iron commands (outside of the keymaps table)
  -- The 'keys' table is the standard LazyVim way to define global keymaps for a plugin.
  keys = {
    -- The first element is the key, the second is the command/function, the third is options
    { '<space>rf', '<cmd>IronFocus<cr>', { desc = 'Iron: Focus REPL' } },
    { '<space>rh', '<cmd>IronHide<cr>', { desc = 'Iron: Hide REPL' } },
  },
}

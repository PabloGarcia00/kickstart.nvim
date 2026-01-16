vim.api.nvim_create_user_command('JupytextToScript', function()
  local current_file = vim.fn.expand '%'

  -- 1. Ensure the buffer is saved
  vim.cmd 'write'

  -- 2. Define the new file path before executing Jupytext
  local file_root = vim.fn.expand '%:r'
  local new_script_file = file_root .. '.py'

  -- 3. Execute Jupytext silently using vim.fn.system()
  -- This runs the command without blocking the Neovim execution flow with a shell screen.
  local command = 'jupytext --to script ' .. current_file
  vim.fn.system(command)

  -- 4. Check if the new file exists before attempting to open it
  if vim.fn.filereadable(new_script_file) == 1 then
    -- 5. Open the newly created script file in the current buffer
    vim.cmd('edit ' .. new_script_file)
    print('Converted and opened: ' .. new_script_file)
  else
    -- Jupytext failed or created a file with a non-standard extension
    print('Jupytext failed or the expected file (' .. new_script_file .. ') was not created.')
  end

  vim.cmd 'redraw!'
end, {
  desc = 'Convert current .ipynb to script format, then open the new script file.',
})

-- Define a keymap to execute this command (e.g., <leader>nc for New Cell)
vim.api.nvim_create_user_command(
  'NewReplBlock',
  -- Function logic is now defined directly here (the callback)
  function()
    local comment_temp = vim.bo.commentstring
    local default_delimiter = '# %%'

    local delimiter
    if comment_temp and comment_temp ~= '' then
      local prefix = string.gsub(comment_temp, '%%s.*', '')
      local trimmed_prefix = string.gsub(prefix, '^%s*(.-)%s*$', '%1')
      if trimmed_prefix ~= '' then
        delimiter = trimmed_prefix .. '%%'
      else
        delimiter = default_delimiter
      end
    else
      delimiter = default_delimiter
    end

    if delimiter == '' then
      delimiter = default_delimiter
    end
    local block_lines = {
      delimiter,
      '',
      delimiter,
    }

    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, current_line, current_line, false, block_lines)
    vim.api.nvim_win_set_cursor(0, { current_line + 2, 0 })
  end,
  {
    nargs = 0,
    desc = 'Insert a new REPL code block marker (dynamic opener/closer).',
  }
)

vim.api.nvim_create_user_command('TelescopePhrases', function(opts)
  local ts_utils = require 'utils.telescope'
  ts_utils.search_lines_in_file(opts.args)
end, {
  nargs = 1,
  complete = 'file',
  desc = 'Search lines in file',
})

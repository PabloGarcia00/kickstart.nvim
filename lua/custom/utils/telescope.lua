local M = {}

local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local conf = require('telescope.config').values

--- Open Telescope to live-grep through a single file without a preview pane.
--- @param file_path string
M.search_lines_in_file = function(file_path)
  local file = io.open(file_path, 'r')
  if not file then
    vim.notify('File not found: ' .. file_path, vim.log.levels.WARN)
    return
  end

  -- Read all lines
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()

  -- Create the Telescope picker
  pickers
    .new({}, {
      prompt_title = 'Search in: ' .. (file_path:match '[^/]+$' or file_path),

      finder = finders.new_table {
        results = lines,
        entry_maker = function(line)
          return {
            value = line,
            display = line,
            ordinal = line,
            filename = file_path,
          }
        end,
      },

      sorter = conf.generic_sorter {},
      previewer = false, -- 🚀 <--- Disable preview window completely
      layout_config = {
        preview_width = 0, -- Force zero width (in case a plugin overrides previewer=false)
      },

      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local entry = require('telescope.actions.state').get_selected_entry()
          require('telescope.actions').close(prompt_bufnr)

          -- Open file and jump to the matching line
          vim.cmd('e ' .. entry.filename)

          -- Find the correct line number
          local lnum = 1
          for i, l in ipairs(lines) do
            if l == entry.value then
              lnum = i
              break
            end
          end

          vim.api.nvim_win_set_cursor(0, { lnum, 0 })
        end)
        return true
      end,
    })
    :find()
end

return M

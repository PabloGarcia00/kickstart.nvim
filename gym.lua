-- 1. The Core Logic
local function generate_gym_set()
  local date = os.date '%Y-%m-%d'
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1]

  -- Fallbacks
  local new_exercise = '_'
  local new_set = '1'
  local prev_line = ''

  -- Get current line content for scouting
  local lines = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)
  prev_line = lines[1] or ''

  -- Scout: Extract Exercise and Set from current line if they exist
  -- We use Lua's internal string.match (NOT vim.cmd) to avoid E867 errors
  if prev_line:find '|' then
    local match_ex, match_set = prev_line:match '|%s*([^|]-)%s*|%s*(%d+)%s*|'
    if match_ex and match_set then
      local clean_ex = vim.trim(match_ex)
      if clean_ex ~= '' and clean_ex ~= '_' then
        new_exercise = clean_ex
        new_set = tostring(tonumber(match_set) + 1)
      end
    end
  end

  -- Construct Template: Date | Exercise | Set | Weight | Reps | Note
  local template = string.format('%s | %s | %s | _ | _ | _', date, new_exercise, new_set)

  -- Insert Logic
  if row == 1 and prev_line == '' then
    vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { template })
  else
    vim.api.nvim_put({ template }, 'l', true, true)
  end

  -- Precise Positioning (Mathematical, no search used)
  local target_col
  local pipe1 = template:find '|'
  if new_exercise == '_' then
    target_col = pipe1 + 1 -- Field 2: Exercise
  else
    local pipe2 = template:find('|', pipe1 + 1)
    local pipe3 = template:find('|', pipe2 + 1)
    target_col = pipe3 + 1 -- Field 4: Weight (Auto-skipped Ex/Set)
  end

  local new_row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_win_set_cursor(0, { new_row, target_col })

  -- Enter Insert mode and delete the "_" placeholder
  vim.cmd 'startinsert'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Del>', true, false, true), 'n', true)
end

-- 2. The Navigation (Enter Key Hop)
local function gym_hop()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local rest_of_line = line:sub(col + 1)

  if rest_of_line:find '_' then
    -- Jump to next placeholder
    vim.fn.search '_'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Del>', true, false, true), 'n', true)
  else
    -- End of line: Exit and generate next set
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
    generate_gym_set()
  end
end

-- 1. The Repair Function
local function repair_gym_ledger()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local updated = false

  for i, line in ipairs(lines) do
    -- Skip empty lines
    if line ~= '' then
      -- Count literal pipes
      local _, pipe_count = line:gsub('|', '|')

      -- We expect exactly 5 pipes for 6 columns
      if pipe_count < 5 then
        -- Append missing " | _" placeholders until we have 5 pipes
        lines[i] = line .. string.rep(' | _', 5 - pipe_count)
        updated = true
      end
    end
  end

  -- Only write back to the buffer if we actually changed something
  if updated then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  end
end

-- 3. Activation Guard
-- Only enable these when opening a file ending in .gym
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.gym',
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set('n', '<leader>n', generate_gym_set, opts)
    vim.keymap.set('i', '<CR>', gym_hop, opts)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = repair_gym_ledger,
    })
    print 'Gym Mode: [,]n for new set | Enter to hop'
  end,
})

local M = {}

--- @param window Window
local function cwd(window)
  return window
    :active_tab()
    :active_pane()
    :get_current_working_dir().file_path
    :sub(2)
end

M.get_head = function(git_dir)
  local f_head = io.open(git_dir .. '/HEAD')

  if f_head then
    local HEAD = f_head:read()
    f_head:close()
    local branch = HEAD:match 'ref: refs/heads/(.+)$'
    if branch then
      return branch
    else
      return HEAD:sub(1, 6)
    end
  end

  return nil
end

--- @param window Window
M.branch = function(window)
  return M.get_head(cwd(window) .. '/.git')
end

return M

local M = {}

M.get_git_head = function(git_dir)
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
M.git_branch = function(window)
  local cwd_uri = window:active_tab():active_pane():get_current_working_dir()
  return M.get_git_head(cwd_uri.file_path:sub(2) .. '/.git')
end

return M

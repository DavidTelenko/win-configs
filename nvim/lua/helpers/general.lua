local M = {}

local is_available = function(fmt)
  return require('conform').get_formatter_info(fmt).available ~= nil
end

local is_config_present = function(fmt)
  return vim.fs.root(vim.fn.getcwd(), require('helpers.configs')[fmt]) ~= nil
end

--- @param predicate fun(fmt: string): boolean
--- @return fun(list: table|string): string[]
local make_require = function(predicate)
  return function(list)
    if type(list) == 'string' then
      return predicate(list) and { list } or {}
    end

    return vim.iter(list):flatten():filter(predicate):totable()
  end
end

---@param list table
---@return table
M.first = function(list)
  return #list == 0 and {} or vim.iter({ list[1] }):flatten():totable()
end

M.require_available = make_require(is_available)
M.require_config = make_require(is_config_present)

return M

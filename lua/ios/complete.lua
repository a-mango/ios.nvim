local keywords = require("ios.keywords")
local M = {}

--- Find the list of candidate commands for the line at `lnum`.
local function candidates_for(lnum)
  local line = vim.fn.getline(lnum)
  if not line:match("^%s") then
    return keywords.global
  end
  for l = lnum - 1, 1, -1 do
    local text = vim.fn.getline(l)
    if text:match("^%S") and not text:match("^!") then
      local first = text:match("^(%S+)")
      return keywords.sections[first] or {}
    end
  end
  return {}
end

function M.omnifunc(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.fn.col(".") - 1
    return line:sub(1, col):match("^%s*()") - 1
  end
  local lnum = vim.fn.line(".")
  local out = {}
  for _, kw in ipairs(candidates_for(lnum)) do
    if kw:sub(1, #base):lower() == base:lower() then
      table.insert(out, { word = kw, menu = "[ios]" })
    end
  end
  table.sort(out, function(a, b) return a.word < b.word end)
  return out
end

M._candidates_for = candidates_for

return M

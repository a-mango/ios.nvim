-- Returns "ios" when one of the first 50 lines starts with an IOS marker.
-- Returning nil hands the file back to the built-in detection.
local function looks_like_ios(_, bufnr)
  if not bufnr then
    return
  end
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
  for _, l in ipairs(lines) do
    if l:match("^version %d") or l:match("^hostname %S")
      or l:match("^interface %a") or l:match("^Building configuration")
      or l:match("^Current configuration") or l:match("^service timestamps") then
      return "ios"
    end
  end
end

-- Generic extensions are matched as patterns with a positive priority so that
-- they run before the built-in extension table without replacing it.
local by_content = { looks_like_ios, { priority = 10 } }

vim.filetype.add({
  extension = {
    ios = "ios",
  },
  filename = {
    ["running-config"] = "ios",
    ["startup-config"] = "ios",
  },
  pattern = {
    [".*%-confg"] = "ios",
    [".*%.cfg"] = by_content,
    [".*%.conf"] = by_content,
    [".*%.txt"] = by_content,
  },
})

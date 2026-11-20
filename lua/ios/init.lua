local M = {}

--- Registers the bundled snippets with LuaSnip when it is installed.
--- Calling it is optional: detection, syntax and completion load without it.
--- @param opts? { snippets?: boolean } set `snippets = false` to skip LuaSnip
function M.setup(opts)
  opts = opts or {}
  if opts.snippets ~= false then
    local ok, loader = pcall(require, "luasnip.loaders.from_vscode")
    if ok then
      local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h:h")
      loader.lazy_load({ paths = { root } })
    end
  end
end

return M

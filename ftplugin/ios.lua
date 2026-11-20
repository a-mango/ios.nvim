if vim.b.did_ftplugin then
  return
end
vim.b.did_ftplugin = 1

local bo = vim.bo
bo.commentstring = "! %s"
bo.comments = ":!"
bo.shiftwidth = 1
bo.tabstop = 1
bo.softtabstop = 1
bo.expandtab = true
bo.omnifunc = "v:lua.require'ios.complete'.omnifunc"
vim.opt_local.iskeyword:append("-")
vim.opt_local.foldmethod = "indent"
-- Open with every fold open, unless the user chose a start level.
if vim.o.foldlevelstart < 0 then
  vim.opt_local.foldlevel = 99
end

vim.b.undo_ftplugin = table.concat({
  "setlocal commentstring< comments< shiftwidth< tabstop< softtabstop< expandtab< omnifunc< iskeyword< foldmethod< foldlevel<",
  "unlet! b:did_ftplugin",
}, " | ")

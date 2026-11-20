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

vim.b.undo_ftplugin = table.concat({
  "setlocal commentstring< comments< shiftwidth< tabstop< softtabstop< expandtab< omnifunc< iskeyword< foldmethod<",
  "unlet! b:did_ftplugin",
}, " | ")

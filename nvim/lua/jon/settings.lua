vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- line number and relative positon
vim.opt.number = true
vim.opt.relativenumber = true

-- search and case sensitivity
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false -- disable line wrapping
vim.opt.scrolloff = 8 -- keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8 -- keep 8 columns visible when scrolling horizontally

vim.opt.clipboard = "unnamedplus" -- makes yanking work with system clipboard

-- Highlight on yank (visual feedback when copying)
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

return {} -- Return an empty table if you want to use this as a module

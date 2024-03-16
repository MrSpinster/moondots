local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  callback = function()
    vim.cmd "hi! Normal guibg=NONE ctermbg=NONE"
    vim.cmd "hi! NonText guibg=NONE ctermbg=NONE"
  end,
})

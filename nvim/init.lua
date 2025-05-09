vim.g.maploader = " "
vim.g.maplocalleader = " "
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.coding" },
})

require("config.options")

vim.keymap.set("n", "<leader>r", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^config") or name:match("^plugins") or name:match("^util") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Reload Neovim config" })

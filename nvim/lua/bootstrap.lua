-- [nfnl] Compiled from bootstrap.fnl by https://github.com/Olical/nfnl, do not edit.
local function bootstrap_lazy()
  local fsm = (vim.uv or vim.loop)
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  if not fsm.fs_stat(lazypath) then
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if (vim.v.shell_error ~= 0) then
      vim.api.nvim_echo({{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"}, {"\nPress any key to exit..."}}, true, {})(vim.fn.getchar(), os.exit(1))
    else
    end
  else
  end
  return vim.opt.rtp:prepend(lazypath)
end
return bootstrap_lazy

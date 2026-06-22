-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Clipboard: context-aware.
-- Inside tmux (including over SSH): use osc52copy which writes OSC52 directly
-- to the tmux client_tty, so the outer terminal receives it regardless of SSH.
-- Locally (no tmux): let Neovim pick the native provider (pbcopy on macOS,
-- wl-copy on Wayland, xclip on X11).
if vim.env.TMUX and vim.env.TMUX ~= "" then
  local osc52copy = vim.fn.expand "~/bin/osc52copy"
  if vim.fn.executable(osc52copy) == 1 then
    vim.g.clipboard = {
      name = "osc52copy",
      copy = {
        ["+"] = { osc52copy },
        ["*"] = { osc52copy },
      },
      paste = {
        ["+"] = { "tmux", "save-buffer", "-" },
        ["*"] = { "tmux", "save-buffer", "-" },
      },
      cache_enabled = 0,
    }
  end
else
  vim.opt.clipboard = "unnamedplus"
end

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})

  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

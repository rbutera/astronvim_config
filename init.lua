-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

if vim.fn.executable "wl-copy" == 1 and vim.fn.executable "wl-paste" == 1 then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy",
      ["*"] = "wl-copy",
    },
    paste = {
      ["+"] = "wl-paste",
      ["*"] = "wl-paste",
    },
    cache_enabled = 0,
  }
end

-- Over SSH, use osc52copy script to write directly to the tmux client tty.
-- nvim's built-in "osc52" writes to stdout which tmux intercepts; the script
-- bypasses that by writing to #{client_tty} directly, same as tmux-yank does.
if vim.env.SSH_CONNECTION or vim.env.SSH_TTY then
  local osc52copy = vim.fn.expand "~/.local/bin/osc52copy"
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
  else
    vim.g.clipboard = "osc52"
  end
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

-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

-- Set key bindings
vim.keymap.set("n", "<C-s>", ":w!<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>o", "o<Esc>k", { desc = "Insert line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>j", { desc = "Insert line above" })
vim.keymap.set({ "n", "v" }, "<leader>yj", "y'>o<Esc>p", { desc = "Duplicate line(s) down" })
vim.keymap.set({ "n", "v" }, "<leader>yk", "y'>O<Esc>p", { desc = "Duplicate line(s) up" })
vim.keymap.set("n", "<leader>kh", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
vim.keymap.set("n", "<leader>kH", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })

vim.keymap.set("n", "gh", function() vim.diagnostic.open_float() end, { desc = "Floating diagnostics" })
-- for spectre
vim.keymap.set("n", "<leader>fs", function() require("spectre").open() end, { desc = "Open Spectre (find/replace)" })
-- search current word
vim.keymap.set(
  "n",
  "<leader>sw",
  function() require("spectre").open_visual { select_word = true } end,
  { desc = "Find/replace with selected word" }
)
-- Set autocommands
vim.api.nvim_create_augroup("packer_conf", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Sync packer after modifying plugins.lua",
  group = "packer_conf",
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

vim.keymap.del("n", "<leader>q")

vim.keymap.set("n", "<leader>q", function() vim.lsp.buf.code_action() end, { desc = "Quick fix / code action" })

local function alpha_on_bye(cmd)
  local bufs = vim.fn.getbufinfo { buflisted = true }
  vim.cmd(cmd)
  if not bufs[2] then
    local ok, snacks = pcall(require, "snacks")
    if ok then snacks.dashboard() end
  end
end

-- vim.keymap.del("n", "<leader>c")
-- if require("core.utils").is_available("bufdelete.nvim") then
--   vim.keymap.set("n", "<leader>x", function()
--     alpha_on_bye("Bdelete!")
--   end, { desc = "Close buffer" })
-- else
--   vim.keymap.set("n", "<leader>x", function()
--     alpha_on_bye("bdelete!")
--   end, { desc = "Close buffer" })
-- end

-- vim.keymap.del("n", "<leader>lr")
vim.keymap.set("n", "<leader>rs", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })

vim.keymap.set("n", "<leader>rf", function() vim.lsp.util.rename() end, { desc = "Rename file" })

vim.keymap.set("n", "<C-P>", function()
  require("telescope.builtin").live_grep {
    additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
  }
end, { desc = "Search files (live grep)" })

vim.keymap.set("n", "<C-p>", function() require("telescope.builtin").find_files() end, { desc = "Search files" })

-- ============================================================
-- VSCodevim compatibility layer
-- Matches keybindings from ~/Library/Application Support/Code/User/settings.json
-- See docs/VSCODEVIM_NEOVIM_COMPARISON.md for full reference
-- ============================================================

vim.o.timeoutlen = 200

-- Helper: move a normal-mode keymap from old_lhs to new_lhs, preserving callback/rhs
local function move_keymap(old_lhs, new_lhs)
  local map = vim.fn.maparg(old_lhs, "n", false, true)
  if not map or not next(map) then return end
  local opts = { desc = map.desc, silent = map.silent == 1 }
  if map.callback then
    vim.keymap.set("n", new_lhs, map.callback, opts)
  elseif map.rhs and map.rhs ~= "" then
    opts.noremap = map.noremap == 1
    vim.keymap.set("n", new_lhs, map.rhs, opts)
  end
  pcall(vim.keymap.del, "n", old_lhs)
end

-- Move buffer ops: <leader>b* → <leader>B* (frees <leader>b for CamelCaseMotion)
for _, k in ipairs({ "bb", "bd", "bc", "bC", "bl", "br", "bp", "b\\", "b|", "bse", "bsr", "bsp", "bsi", "bsm" }) do
  move_keymap("<leader>" .. k, "<leader>B" .. k:sub(2))
end

-- Move ToggleTerm: <leader>t* → <leader>T* (frees <leader>t* for tab operations)
for _, k in ipairs({ "tf", "tv", "th", "tn", "tp", "tl", "tu" }) do
  move_keymap("<leader>" .. k, "<leader>T" .. k:sub(2))
end

-- Remove AstroNvim mappings that conflict with VSCodevim bindings
pcall(vim.keymap.del, "n", "<leader>w") -- Save (use <C-s> instead)
pcall(vim.keymap.del, "n", "<leader>e") -- Neo-tree toggle (use <leader>kh instead)
pcall(vim.keymap.del, "n", "<leader>h") -- Home Screen
pcall(vim.keymap.del, "n", "<leader>Q") -- Exit AstroNvim (use :qa instead)
pcall(vim.keymap.del, "n", "<leader>R") -- Rename file (use <leader>rf instead)

-- Which-key group labels for relocated groups
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.add {
    { "<leader>B", group = "Buffers" },
    { "<leader>Bs", group = "Sort Buffers" },
    { "<leader>T", group = "Terminal" },
    { "<leader>t", group = "Tabs" },
  }
end

-- CamelCaseMotion: re-establish on <leader>w/b/e (now free from AstroNvim conflicts)
for _, mode in ipairs { "n", "x", "o" } do
  vim.keymap.set(mode, "<leader>w", "<Plug>CamelCaseMotion_w", { desc = "CamelCase word forward" })
  vim.keymap.set(mode, "<leader>b", "<Plug>CamelCaseMotion_b", { desc = "CamelCase word backward" })
  vim.keymap.set(mode, "<leader>e", "<Plug>CamelCaseMotion_e", { desc = "CamelCase word end" })
end
for _, mode in ipairs { "o", "x" } do
  vim.keymap.set(mode, "i<leader>w", "<Plug>CamelCaseMotion_iw", { desc = "inner CamelCase word" })
  vim.keymap.set(mode, "i<leader>b", "<Plug>CamelCaseMotion_ib", { desc = "inner CamelCase back" })
  vim.keymap.set(mode, "i<leader>e", "<Plug>CamelCaseMotion_ie", { desc = "inner CamelCase end" })
end

-- Navigation
vim.keymap.set("n", "<leader>h", "^", { desc = "First non-blank character" })
vim.keymap.set("n", "<leader>H", "0", { desc = "Start of line" })
vim.keymap.set("n", "]b", function() require("astrocore.buffer").nav(vim.v.count1) end, { desc = "Next buffer" })
vim.keymap.set("n", "[b", function() require("astrocore.buffer").nav(-vim.v.count1) end, { desc = "Previous buffer" })

-- LSP overrides
vim.keymap.set("n", "gl", function() vim.lsp.buf.hover() end, { desc = "Hover info" })
vim.keymap.set("n", "<leader>Q", function() vim.lsp.buf.code_action() end, { desc = "Auto fix" })
vim.keymap.set("n", "<leader>p", function()
  require("telescope.builtin").lsp_definitions { jump_type = "never" }
end, { desc = "Peek definition" })

-- Tab operations (relocated from ToggleTerm's <leader>t* prefix)
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprev<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
vim.keymap.set("n", "<leader>tx", function() require("astrocore.buffer").close() end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>tl", function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd "wincmd l"
  vim.api.nvim_set_current_buf(buf)
end, { desc = "Show buffer in right split" })
vim.keymap.set("n", "<leader>th", function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd "wincmd h"
  vim.api.nvim_set_current_buf(buf)
end, { desc = "Show buffer in left split" })

-- Splits
vim.keymap.set("n", "<leader>\\", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>|", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Search
vim.keymap.set("n", "<leader><leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Visual star search (matches vim.visualstar in VSCodevim)
vim.keymap.set("v", "*", '"zy/\\V<C-r>z<CR>', { desc = "Search selection forward" })
vim.keymap.set("v", "#", '"zy?\\V<C-r>z<CR>', { desc = "Search selection backward" })

if vim.fn.has "wsl" == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankToWindowsClipboard", { clear = true }),
    callback = function() vim.fn.system("clip.exe", vim.fn.getreg '"') end,
  })
end

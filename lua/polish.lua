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
  if require("core.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
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

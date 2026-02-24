# AstroNvim v3 Customization Inventory

This inventory was reconstructed from:

- `rbutera/astronvim_old` commit `0082b8e854072565844493652c90003dce844cda` (initial v3 migration)
- `rbutera/astronvim_old` commit `ba2fc9ba825e3c2b6f86ae7d4094c9a78059e5c6` (WSL compatibility)
- current repo state in `/home/rai/.config/nvim`

## Core UI and behavior

- Colorscheme set to Catppuccin.
- Transparent Catppuccin background.
- Custom dashboard ASCII header (originally on `alpha-nvim`, later ported to `snacks.nvim` dashboard).
- Added Leetcode launcher on dashboard.
- Neo-tree configured to show dotfiles and gitignored files.
- Rooter enabled with `autochdir = true` and global scope.

## Keymaps and editing workflow

- `<C-s>` save file.
- `<leader>o` / `<leader>O` insert line below/above while staying in normal mode.
- `<leader>yj` / `<leader>yk` duplicate line(s) down/up.
- `<leader>kh` / `<leader>kH` toggle/focus Neo-tree.
- `gh` open floating diagnostics.
- `<leader>fs` open Spectre.
- `<leader>sw` Spectre with current word.
- `<leader>q` remapped to code actions.
- `<leader>rs` rename symbol.
- `<leader>rf` rename file helper mapping.
- `<C-p>` find files (Telescope).
- `<C-P>` live grep including hidden/unignored files.

## Language and tooling choices

- Community language packs enabled: Lua, Rust, Python, Tailwind, Terraform, Svelte, YAML, SQL, TypeScript, Go, Docker, Gleam, JSON, Bash.
- Motion/search plugins: leap.nvim, nvim-surround, nvim-spectre.
- Misc plugins/workflow: todo-comments, trouble, comment.nvim, boole.nvim, vim-eunuch, nvim-ufo, multiple-cursors, leetcode.nvim, presence.nvim, fidget.nvim, searchbox.nvim.

## Historical AI completion changes

- v3 period started with Copilot + copilot-cmp.
- later migrated to Supermaven + cmp source in this repo.
- for v5 migration, Supermaven removed (as requested).

## WSL compatibility customization

- Added Windows clipboard bridge on yank (`TextYankPost` -> `clip.exe`) when `vim.fn.has("wsl") == 1`.
- This behavior has been retained in current config.

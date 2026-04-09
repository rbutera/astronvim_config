# Log

## 2026-04-09

### Add VSCodevim compatibility layer and comparison docs

**Problem:** CamelCaseMotion (`<leader>w/b/e`) was completely broken — AstroNvim
mapped `<leader>w` to save, `<leader>e` to Neo-tree toggle, and `<leader>b` was
a which-key prefix for buffer ops. All three CamelCaseMotion keys were shadowed.

**Changes to `lua/polish.lua`:**
- Moved buffer ops from `<leader>b*` → `<leader>B*` (capital B)
- Moved ToggleTerm from `<leader>t*` → `<leader>T*` (capital T)
- Removed redundant AstroNvim mappings: `<leader>w` (save, use `<C-s>`),
  `<leader>e` (Neo-tree, use `<leader>kh`), `<leader>h` (home screen),
  `<leader>Q` (exit, use `:qa`), `<leader>R` (rename, use `<leader>rf`)
- Re-established CamelCaseMotion on `<leader>w/b/e` (all modes + text objects)
- Added VSCodevim compat bindings: `<leader>h`/`H` (line nav), `]b`/`[b`
  (buffer cycling), `gl` (hover), `<leader>Q` (code action), `<leader>p`
  (peek definition), `<leader>t*` (tab ops), `<leader>\`/`|` (splits),
  `<leader><leader>/` (clear search), visual `*`/`#` (star search)
- Set `timeoutlen=200` for snappier which-key resolution

**Created `docs/VSCODEVIM_NEOVIM_COMPARISON.md`:**
- Full comparison of emulated extensions vs Neovim plugin equivalents
- Feature gaps in both directions
- Keybinding differences grouped by category
- Remaining gotchas (fold keys, sneak vs leap, relocated groups)

## 2026-03-31

### Add nvim-puppeteer for template string auto-conversion

Added `chrisgrieser/nvim-puppeteer` to `lua/plugins/user.lua`. This replaces
`axelvc/template-string.nvim` from the old AstroNvim config, which was never
carried over during the v3→v5 migration.

The plugin auto-converts string literals to template literals (backticks) when
`${` is typed inside them in JS/TS/JSX/TSX files, and reverses the conversion
when the placeholder is removed. Also supports Python f-strings. Zero config
required; depends on nvim-treesitter (already present).



### Simplify Neovim clipboard handling

Replaced the custom SSH, tmux, and Wayland clipboard overrides in
`init.lua` with the standard Neovim setting:

```lua
vim.opt.clipboard = "unnamedplus"
```

This makes normal `y`, `dd`, and `p` use the `+` register and keeps Neovim
aligned with the system clipboard by default.

### Why the old setup was removed

The previous SSH-specific `vim.g.clipboard` override copied via `osc52copy`
but pasted via `tmux save-buffer -`.

That mixed two different clipboard sources:

- Neovim copy targeted the local system clipboard over OSC52.
- Neovim paste read tmux's internal paste buffer.

The result was confusing register behavior, especially over SSH, where `p`
could paste from a different source than `y` or terminal paste.

### Expected behavior now

- `y`, `yy`, `dd`, and `p` follow `unnamedplus`.
- `"+y` and `"+p` remain the explicit system clipboard forms.
- Provider selection is delegated back to Neovim 0.11, which can use native
  clipboard tools locally and OSC52 in terminal sessions when appropriate.

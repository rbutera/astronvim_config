# VSCodevim vs Neovim Configuration Comparison

Cross-reference for switching between VSCode (with VSCodevim) and Neovim (AstroNvim v5). Covers plugin equivalents, feature gaps, and keybinding discrepancies.

Both configs use `<Space>` as leader, relative line numbers, system clipboard, and Catppuccin Mocha theme.

---

## Emulated Extension Equivalents

VSCodevim ships several "emulated vim plugins" that can be toggled on. The table below maps each to the corresponding Neovim plugin.

| VSCodevim Feature | Enabled | Neovim Equivalent | Match Quality | Notes |
|---|---|---|---|---|
| `vim.surround` | Yes | [nvim-surround](https://github.com/kylechui/nvim-surround) | Identical | `ys`, `ds`, `cs` — same keybinds, same behavior |
| `vim.sneak` | Yes | [leap.nvim](https://github.com/ggandor/leap.nvim) | Partial | Both use `s`/`S` for 2-char search, but Leap adds label-based disambiguation instead of `;`/`,` repeat. See [Motion Differences](#motion--jump-navigation) |
| `vim.easymotion` | Yes | *Not installed* | Missing | VSCodevim provides `<leader><leader>w`, `<leader><leader>b`, `<leader><leader>f{char}`, etc. Neovim has no equivalent. Leap covers some ground but lacks the labeled-targets-everywhere UI |
| `vim.camelCaseMotion` | Yes | [CamelCaseMotion](https://github.com/bkad/CamelCaseMotion) | Identical | Both map `<leader>w`, `<leader>b`, `<leader>e` + `i<leader>w` text objects |
| `vim.highlightedyank` | Yes | AstroNvim built-in | Identical | AstroNvim highlights yanked text by default via `vim.highlight.on_yank` |
| `vim.hlsearch` | Yes | Neovim default | Identical | Both highlight search matches |
| `vim.visualstar` | Yes | *Not installed* | Missing | `*` and `#` in visual mode search the selection. Neovim has no equivalent plugin |
| `vim.foldfix` | Yes | N/A | N/A | VSCode-specific cursor fix for folded regions |

---

## Features in Neovim but NOT in VSCodevim

These Neovim plugins/features have no VSCodevim equivalent:

| Neovim Plugin | What It Does | Closest VSCode Alternative |
|---|---|---|
| [leap.nvim](https://github.com/ggandor/leap.nvim) (label mode) | Labeled 2-char jump targets across visible buffer | Sneak only goes to the *first* match; EasyMotion is the closest but has different keybinds |
| [multiple-cursors.nvim](https://github.com/brenton-leighton/multiple-cursors.nvim) | `<C-j>`/`<C-k>` add cursors up/down, `<Leader>a` adds at next word match | VSCode's native multi-cursor (`Cmd+D`, `Ctrl+Shift+L`) — not controlled by VSCodevim |
| [nvim-spectre](https://github.com/nvim-pack/nvim-spectre) | Project-wide find and replace with preview | VSCode's built-in Find & Replace in Files |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Aggregated diagnostics panel | VSCode's Problems panel (built-in) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight & search TODO/FIXME/HACK | Todo Tree extension (you have it installed) |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | LSP/Treesitter-powered code folding | VSCode built-in folding (already works well) |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Sticky function/class header at top of buffer | VSCode's `editor.stickyScroll.enabled` (you have it on) |
| [boole.nvim](https://github.com/nat-418/boole.nvim) | `<C-a>`/`<C-x>` toggles true/false, yes/no, etc. | No direct equivalent |
| [nvim-puppeteer](https://github.com/chrisgrieser/nvim-puppeteer) | Auto-convert JS strings to template literals | No direct equivalent |
| [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb) | Gutter icon when code actions available | VSCode has this built in |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress indicator | VSCode shows this in the status bar |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Key binding discovery popup | No equivalent (VSCodevim has no hint system) |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Code outline / symbol sidebar | VSCode Outline view (built-in) |
| [better-escape.nvim](https://github.com/max397574/better-escape.nvim) | `jk`/`jj` to exit insert mode without delay | VSCodevim supports `"vim.insertModeKeyBindings"` but you haven't configured it |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, buffers, etc. | VSCode's Quick Open / Command Palette |
| [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) | Floating signature help while typing | VSCode has this built in |

## Features in VSCodevim but NOT in Neovim

| VSCodevim Feature | What It Does | Potential Neovim Plugin |
|---|---|---|
| EasyMotion (`<leader><leader>` prefix) | Label all word starts, line targets, char targets across visible buffer | [flash.nvim](https://github.com/folke/flash.nvim) or [hop.nvim](https://github.com/smoka7/hop.nvim) |
| Visual Star (`*`/`#` in visual mode) | Search for visually selected text | [vim-visual-star-search](https://github.com/nelstrom/vim-visual-star-search) |
| Quote transform (`<leader>'`) | Cycle between `'`, `"`, `` ` `` | [nvim-surround](https://github.com/kylechui/nvim-surround) can do `cs'"` etc. but it's manual, not a cycle |
| Smart Relative Line (`vim.smartRelativeLine`) | Show absolute numbers in insert mode, relative in normal | AstroNvim can be configured with an autocmd |

---

## Keybinding Differences

### Motion & Jump Navigation

| Action | VSCodevim | Neovim | Conflict? |
|---|---|---|---|
| **Sneak forward** | `s{char}{char}` then `;`/`,` to repeat | `s{char}{char}` then pick a label | Behavioral: Leap labels instead of repeating |
| **Sneak backward** | `S{char}{char}` | `S{char}{char}` | Same trigger, same Leap label behavior |
| **EasyMotion word** | `<leader><leader>w` | *unmapped* | Missing in Neovim |
| **EasyMotion back** | `<leader><leader>b` | *unmapped* | Missing in Neovim |
| **EasyMotion find char** | `<leader><leader>f{char}` | *unmapped* | Missing in Neovim |
| **EasyMotion search char** | `<leader><leader>s{char}` | *unmapped* | Missing in Neovim |
| **EasyMotion line down** | `<leader><leader>j` | *unmapped* | Missing in Neovim |
| **EasyMotion line up** | `<leader><leader>k` | *unmapped* | Missing in Neovim |
| **CamelCase word** | `<leader>w` | `<leader>w` | Identical (AstroNvim's save removed, use `<C-s>`) |
| **CamelCase back** | `<leader>b` | `<leader>b` | Identical (buffer ops moved to `<leader>B*`, fires instantly) |
| **CamelCase end** | `<leader>e` | `<leader>e` | Identical (Neo-tree toggle removed, use `<leader>kh`) |
| **Visual star search** | `*` / `#` in visual mode | Not available | Missing in Neovim |
| **Go to start of line** | `<leader>H` → `0` | *unmapped* | Missing in Neovim |
| **Go to first non-blank** | `<leader>h` → `^` | *unmapped* | Missing in Neovim |

### Buffer & Tab Management

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Next buffer** | `]b` | `]b` (added), `L` | Aligned — both `]b` and `L` work in Neovim now |
| **Prev buffer** | `[b` | `[b` (added), `H` | Aligned — both `[b` and `H` work in Neovim now |
| **Close buffer** | `<leader>c`, `<leader>bd`, `<leader>tx` | `<leader>c` (AstroNvim), `<leader>bd` | Mostly aligned |
| **Close other buffers** | `<leader>bc` | `<leader>bc` (AstroNvim) | Aligned |
| **Close all buffers** | `<leader>bC` | `<leader>bC` (AstroNvim) | Aligned |
| **Close buffers to left** | `<leader>bl` | `<leader>bl` (AstroNvim) | Aligned |
| **Close buffers to right** | `<leader>br` | `<leader>br` (AstroNvim) | Aligned |
| **Show all buffers** | `<leader>bb`, `<leader>fb` | `<leader>fb` (Telescope), `<leader>bb` (AstroNvim) | Aligned |
| **New tab** | `<leader>tt` | *unmapped* | Missing in Neovim |
| **Next/prev tab** | `<leader>tn` / `<leader>tp` | *unmapped* | Missing in Neovim |
| **Close all other tabs** | `<leader>to` | *unmapped* | Missing in Neovim |
| **Move editor to next/prev group** | `<leader>tl` / `<leader>th` | *unmapped* | Missing in Neovim |

### Window Splitting

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Vertical split** | `<leader>\` | `<leader>\|` (AstroNvim) | Different! VSCodevim uses `\`, AstroNvim uses `\|` |
| **Horizontal split** | `<leader>\|` | `<leader>\` or `<leader>-` (AstroNvim varies) | Swapped from VSCodevim! |
| **Toggle layout** | `<leader>5` | *unmapped* | Missing in Neovim |

### LSP & Code Intelligence

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Hover info** | `K`, `gl`, `<leader>ld` | `K` (default) | Aligned on `K`. VSCodevim's `gl` does hover; Neovim's `gl` does **diagnostic float** instead |
| **Diagnostic float** | `<leader>d` (remapped to `gh`) | `gh` (custom), `gl` (AstroNvim default) | Different paths: VSCodevim needs `<leader>d`, Neovim uses `gh` or `gl` |
| **Code action / Quick fix** | `<leader>q`, `<leader>la` | `<leader>q` (custom), `<leader>la` (AstroNvim) | Aligned |
| **Auto fix** | `<leader>Q` | *unmapped* | Missing in Neovim |
| **Rename symbol** | `<leader>rs`, `<leader>lr` | `<leader>rs` (custom), `<leader>lr` (AstroNvim) | Aligned |
| **Rename file** | `<leader>rf` | `<leader>rf` (custom, but calls `vim.lsp.util.rename()` which may not work as expected) | Aligned in intent |
| **Go to definition** | `gd` | `gd` | Identical |
| **Go to references** | `gr`, `<leader>lR` | `gr`, `<leader>lR` (AstroNvim) | Aligned |
| **Peek definition** | `<leader>p` | *unmapped* | Missing in Neovim (could use Telescope LSP) |
| **Format document** | `<leader>lf` | `<leader>lf` (AstroNvim) | Aligned |
| **Go to symbol** | `<leader>t` | `<leader>ls` (AstroNvim) | Different key |
| **Go to workspace symbol** | `<leader>T` | `<leader>lS` (AstroNvim) | Different key |
| **Next diagnostic** | `]d` | `]d` (Neovim default) | Aligned |
| **Prev diagnostic** | `[d` | `[d` (Neovim default) | Aligned |
| **Refactor menu** | `<leader>rr` | *unmapped* | Missing in Neovim |
| **Change all occurrences** | `<leader>ro` | *unmapped* | Missing in Neovim |

### Search & Find

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Find files** | `<leader>ff` | `<leader>ff` (AstroNvim/Telescope), `<C-p>` (custom) | Aligned, plus Neovim has extra `<C-p>` binding |
| **Grep / find in files** | `<leader>fw` | `<leader>fw` (AstroNvim/Telescope), `<C-P>` (custom) | Aligned, plus Neovim has extra `<C-P>` binding |
| **Find and replace (project)** | `<leader>fs` | `<leader>fs` (Spectre) | Aligned |
| **Find/replace current word** | *unmapped* | `<leader>sw` (Spectre) | Neovim-only |
| **Show all editors/buffers** | `<leader>fb` | `<leader>fb` (Telescope) | Aligned |
| **Open recent** | `<leader>fo` | `<leader>fo` (AstroNvim) | Aligned |
| **Clear search highlight** | `<leader><leader>/` | *unmapped* | Missing in Neovim (use `:noh` manually) |

### Editing & Text Manipulation

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Save file** | `<C-s>` | `<C-s>` (custom) | Aligned |
| **Insert blank line below** | `<leader>o` → `o<Esc>k$` | `<leader>o` → `o<Esc>k` | Aligned (minor: VSCode moves to `$`, Neovim stays in column) |
| **Insert blank line above** | `<leader>O` → `O<Esc>j_` | `<leader>O` → `O<Esc>j` | Aligned (minor: VSCode goes to `_` first non-blank) |
| **Duplicate lines down** | `<leader>yj` | `<leader>yj` | Aligned |
| **Duplicate lines up** | `<leader>yk` | `<leader>yk` | Aligned |
| **Duplicate selection** | `<leader>yy` (visual) | *unmapped* | Missing in Neovim visual mode |
| **Open link under cursor** | `<leader><CR>` | `gx` (Neovim default) | Different key |
| **Select all** | `leader va` (appears to be a typo — missing `<>`) | *unmapped* | N/A |
| **Toggle boolean** | *unmapped* | `<C-a>` / `<C-x>` (boole.nvim) | Neovim-only |

### Commenting

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Toggle line comment** | `<leader>/` | `<leader>/` (AstroNvim) | Aligned |
| **Toggle block comment** | `<leader><leader>/` (visual) | `gb` + motion (Comment.nvim) | Different: VSCodevim uses leader combo, Neovim uses `gb` operator |

### Folding

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Fold all** | `zC` | `zM` (nvim-ufo) | Different! `zC` in standard vim = close fold under cursor recursively |
| **Unfold all** | `zO` | `zR` (nvim-ufo) | Different! `zO` in standard vim = open fold under cursor recursively |
| **Close all (standard)** | `zM` (standard vim) | `zM` (nvim-ufo) | Aligned if you use standard keys |
| **Open all (standard)** | `zR` (standard vim) | `zR` (nvim-ufo) | Aligned if you use standard keys |

> **Gotcha:** Your VSCodevim maps `zC` → foldAll and `zO` → unfoldAll, which shadows the standard vim meaning of those keys. In Neovim, `zC`/`zO` retain their default behavior (close/open fold under cursor recursively). Use `zM`/`zR` in Neovim instead.

### File Explorer & UI

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Toggle sidebar/explorer** | `` <leader>` ``, `<leader>kl` | `<leader>e` (AstroNvim), `<leader>kh` (custom) | Different keys |
| **Reveal file in explorer** | `<leader>kh` | `<leader>e` toggles tree, no "reveal current file" mapped | Neovim's `<leader>kh` toggles tree, doesn't reveal |
| **Focus explorer** | `<leader>kl` toggles sidebar | `<leader>kH` (custom) | Similar |
| **Toggle line numbers** | `<leader>l` | `<leader>ul` (AstroNvim) | Different prefix |

### Multi-Cursor

| Action | VSCodevim | Neovim | Notes |
|---|---|---|---|
| **Add cursor down** | *VSCode native: `Cmd+Alt+Down`* | `<C-j>` or `<C-Down>` | Different — Neovim uses multiple-cursors.nvim |
| **Add cursor up** | *VSCode native: `Cmd+Alt+Up`* | `<C-k>` or `<C-Up>` | Different |
| **Select next occurrence** | `gs` (visual), `Ctrl+x` (visual) | `<Leader>a` | Different keys |
| **Skip to next occurrence** | *not mapped* | `<Leader>A` | Neovim-only |

---

## Key Conflicts & Gotchas

These are the things most likely to trip you up when switching editors:

1. **Fold keys are non-standard in VSCodevim**: You've remapped `zC`→foldAll and `zO`→unfoldAll in VSCodevim. In Neovim, use `zM`/`zR` for the same effect.

2. **Sneak repeat vs Leap labels**: In VSCodevim, after `s{char}{char}` you press `;` to go to the next match. In Neovim (Leap), you see labeled targets and press a label key to jump directly. Different muscle memory.

3. **Buffer ops moved to `<leader>B`**: AstroNvim's buffer operations are now under `<leader>B*` (capital B) in Neovim. In VSCodevim they remain on `<leader>b*`. CamelCaseMotion `<leader>b` fires instantly in Neovim with no timeout.

4. **ToggleTerm moved to `<leader>T`**: Terminal operations are now under `<leader>T*` (capital T). Tab operations use `<leader>t*`.

5. **`<leader>o`/`<leader>O` override**: In AstroNvim, `<leader>o` is normally "toggle Neo-tree focus". polish.lua overrides it with "insert blank line below". If you ever remove that override, the behavior changes.

---

## Changes Applied

All changes live in `lua/polish.lua` in the "VSCodevim compatibility layer" section.

### Relocated AstroNvim Groups

| Old Prefix | New Prefix | Group | Why |
|---|---|---|---|
| `<leader>b*` | `<leader>B*` | Buffer operations | Frees `<leader>b` for instant CamelCaseMotion backward |
| `<leader>t*` | `<leader>T*` | ToggleTerm | Frees `<leader>t*` for VSCodevim tab operations |

### Removed AstroNvim Mappings (redundant)

| Removed | Was | Already Covered By |
|---|---|---|
| `<leader>w` | Save | `<C-s>` |
| `<leader>e` | Toggle Neo-tree | `<leader>kh` |
| `<leader>h` | Home Screen | N/A (rarely needed) |
| `<leader>Q` | Exit AstroNvim | `:qa` |
| `<leader>R` | Rename file | `<leader>rf` |

### New VSCodevim-Compatible Bindings

| Binding | Action | Matches VSCodevim |
|---|---|---|
| `<leader>w` / `<leader>b` / `<leader>e` | CamelCaseMotion (forward / backward / end) | Yes — fires instantly, no timeout |
| `i<leader>w` / `i<leader>b` / `i<leader>e` | CamelCaseMotion text objects | Yes |
| `<leader>h` / `<leader>H` | First non-blank (`^`) / start of line (`0`) | Yes |
| `]b` / `[b` | Next / previous buffer | Yes |
| `gl` | Hover info (was: diagnostic float) | Yes |
| `<leader>Q` | Auto fix (code action) | Yes |
| `<leader>p` | Peek definition (Telescope) | Yes |
| `<leader>tt` / `<leader>tn` / `<leader>tp` | New tab / next tab / prev tab | Yes |
| `<leader>to` / `<leader>tx` | Close other tabs / close buffer | Yes |
| `<leader>tl` / `<leader>th` | Show buffer in right/left split | Approximate |
| `<leader>\` / `<leader>\|` | Vertical / horizontal split | Yes |
| `<leader><leader>/` | Clear search highlights | Yes |
| `*` / `#` (visual mode) | Search selection forward / backward | Yes (`vim.visualstar`) |

### Other Settings

| Setting | Value | Why |
|---|---|---|
| `timeoutlen` | 200ms (was 500ms) | Faster which-key resolution; CamelCaseMotion keys fire instantly anyway since their prefixes have no sub-keys |

### Not Yet Implemented (optional future changes)

| Change | Notes |
|---|---|
| Switch Leap → flash.nvim | Would add EasyMotion-like `<leader><leader>w` labeled jumps. Medium risk — changes motion workflow |
| Smart relative line numbers | Show absolute in insert mode, relative in normal. Needs an autocmd |

# Migration Record: AstroNvim v4 -> v5

## References

- v5 migration guide: https://docs.astronvim.com/v5/configuration/migration-guide
- AstroNvim template (v5): https://github.com/AstroNvim/template

## Plan used

1. Update AstroNvim core version pin to v5.
2. Remove v5-incompatible completion customization based on `nvim-cmp`.
3. Remove Supermaven integration.
4. Port dashboard customizations from Alpha to Snacks.
5. Keep and re-validate custom keymaps/plugins.
6. Run headless Neovim startup validation.

## Changes applied

- Updated `lua/lazy_setup.lua`:
  - `version = "^4"` -> `version = "^5"`
- Removed `lua/plugins/cmp.lua`:
  - v5 uses `Saghen/blink.cmp` instead of `hrsh7th/nvim-cmp`.
  - removed obsolete `supermaven` completion source wiring.
- Updated `lua/plugins/user.lua`:
  - removed `supermaven-inc/supermaven-nvim` plugin.
  - moved dashboard override from `goolord/alpha-nvim` to `folke/snacks.nvim` dashboard preset.
  - preserved custom ASCII header and Leetcode entry.
  - normalized legacy `requires` keys to `dependencies` where present.
  - corrected Catppuccin plugin declaration to `catppuccin/nvim` with `name = "catppuccin"`.
- Updated `lua/polish.lua`:
  - replaced Alpha-specific fallback call with Snacks dashboard fallback.
  - restored/retained WSL yank-to-clipboard compatibility (`clip.exe`).

## Repo decision

- No new repository is required.
- Existing `origin` is `git@github.com:rbutera/astronvim_config.git` and remains valid.

## Next checks after first v5 launch

1. Run `:Lazy sync` and restart Neovim.
2. Run `:checkhealth`.
3. Verify dashboard key `L` opens Leetcode.
4. Verify completion behavior with Blink (especially `<Tab>` interaction).
5. Verify WSL clipboard yank behavior (if on WSL).

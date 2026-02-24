# Migration Record: AstroNvim v3 -> v4

## References

- Archived v4 migration guide: https://web.archive.org/web/20250323005224/https://docs.astronvim.com/configuration/v4_migration/
- Existing v3 migration baseline commit: `0082b8e854072565844493652c90003dce844cda`

## What was already true in this repo

This repo was already on the v4-style structure when this migration work started:

- `lazy_setup.lua` bootstrap present.
- modular config structure (`community.lua`, `polish.lua`, `lua/plugins/*.lua`).
- AstroNvim configured through `import = "astronvim.plugins"`.

## v3 customizations preserved into v4-compatible structure

- Keymaps and polish workflow carried into `lua/polish.lua`.
- Plugin customizations carried into `lua/plugins/user.lua`.
- Community packs and motion/search tools preserved in `lua/community.lua`.
- UI customization (Catppuccin + custom dashboard branding) retained.
- WSL clipboard compatibility retained.

## Notes

- The old v3-style monolithic `init.lua` custom config had already been split previously into v4 modules.
- This migration pass focused on validating parity and preserving behavior rather than redoing the already-finished v3->v4 structural migration.

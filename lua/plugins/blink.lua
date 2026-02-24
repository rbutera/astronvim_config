---@type LazySpec
return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {
      -- Some cmp sources only register when they detect nvim-cmp.
      impersonate_nvim_cmp = true,
    },
  },
  {
    "Saghen/blink.cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = {
      sources = {
        -- Ported intent from old nvim-cmp config (minus supermaven):
        -- lsp > snippets > emoji > buffer > path
        default = { "lsp", "snippets", "emoji", "buffer", "path" },
        providers = {
          lsp = { score_offset = 1000 },
          snippets = { score_offset = 750 },
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            score_offset = 700,
            min_keyword_length = 2,
          },
          buffer = { score_offset = 500 },
          path = { score_offset = 250 },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}

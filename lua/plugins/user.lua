-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      table.insert(opts.section.buttons.val, opts.button("L", "  Leetcode", ":Leet"))

      -- customize the dashboard header
      opts.section.header.val = {
        " ",
        " ",
        " ",
        " ",
        " ██████  ██      ██   ██ ███████",
        "██       ██      ██   ██ ██    ",
        "██   ███ ██      ███████ █████ ",
        "██    ██ ██      ██   ██ ██    ",
        " ██████  ███████ ██   ██ ██    ",
        " ",
        " ",
        " ",
      }
      return opts
    end,
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  { "j-hui/fidget.nvim", lazy = false },
  { "VonHeikemen/searchbox.nvim", lazy = false },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end,
  },
  {
    "folke/lsp-colors.nvim",
    lazy = false,
  },
  {
    "kosayoda/nvim-lightbulb",
    lazy = false,
    requires = "antoinemadec/FixCursorHold.nvim",
    config = function() require("nvim-lightbulb").setup { autocmd = { enabled = true } } end,
  },
  {
    "bkad/CamelCaseMotion",
    lazy = false,
    config = function() vim.api.nvim_set_var("camelcasemotion_key", "<leader>") end,
  },
  {
    "tpope/vim-eunuch",
    lazy = false,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { cpp = true },
        -- color = {
        --   suggestion_color = "#ffffff",
        --   cterm = 244,
        -- },
        log_level = "warn", -- set to "off" to disable logging completely
        disable_inline_completion = true, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built in keymaps for more manual control
      }
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      -- vim.o.foldcolumn = "0"
      -- vim.o.foldnestmax = 3
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      local ftMap = {
        vim = "indent",
        python = { "indent" },
        git = "",
      }

      local function customizeSelector(bufnr)
        local function handleFallbackException(err, providerName)
          if type(err) == "string" and err:match "UfoFallbackException" then
            return require("ufo").getFolds(providerName, bufnr)
          else
            return require("promise").reject(err)
          end
        end

        return require("ufo")
          .getFolds("lsp", bufnr)
          :catch(function(err) return handleFallbackException(err, "treesitter") end)
          :catch(function(err) return handleFallbackException(err, "indent") end)
      end

      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype) return ftMap[filetype] or customizeSelector end,
      }
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  {
    "numToStr/Comment.nvim",
    config = function() require("Comment").setup() end,
  },
  {
    "nat-418/boole.nvim",
    lazy = false,
    command = "Boole",
    config = function()
      require("boole").setup {
        mappings = {
          increment = "<C-a>",
          decrement = "<C-x>",
        },
      }
    end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "rcarriga/nvim-notify",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- configuration goes here
      ---@type string
      arg = "leetcode.nvim",

      ---@type lc.lang
      lang = "typescript",

      cn = { -- leetcode.cn
        enabled = false, ---@type boolean
        translator = true, ---@type boolean
        translate_problems = true, ---@type boolean
      },

      ---@type lc.storage
      storage = {
        home = vim.fn.stdpath "data" .. "/leetcode",
        cache = vim.fn.stdpath "cache" .. "/leetcode",
      },

      ---@type table<string, boolean>
      plugins = {
        non_standalone = false,
      },

      ---@type boolean
      logging = true,

      injector = {}, ---@type table<lc.lang, lc.inject>

      cache = {
        update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
      },

      console = {
        open_on_runcode = true, ---@type boolean

        dir = "row", ---@type lc.direction

        size = { ---@type lc.size
          width = "90%",
          height = "75%",
        },

        result = {
          size = "60%", ---@type lc.size
        },

        testcase = {
          virt_text = true, ---@type boolean

          size = "40%", ---@type lc.size
        },
      },

      description = {
        position = "left", ---@type lc.position

        width = "40%", ---@type lc.size

        show_stats = true, ---@type boolean
      },

      hooks = {
        ---@type fun()[]
        ["enter"] = {},

        ---@type fun(question: lc.ui.Question)[]
        ["question_enter"] = {},

        ---@type fun()[]
        ["leave"] = {},
      },

      keys = {
        toggle = { "q" }, ---@type string|string[]
        confirm = { "<CR>" }, ---@type string|string[]

        reset_testcases = "r", ---@type string
        use_testcase = "U", ---@type string
        focus_testcases = "H", ---@type string
        focus_result = "L", ---@type string
      },

      ---@type lc.highlights
      theme = {},

      ---@type boolean
      image_support = false,
      -- configuration goes here
    },
  },
}

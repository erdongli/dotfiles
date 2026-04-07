return {
  {
    -- gitsigns
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
        untracked = { text = "|" },
      },
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = require("gitsigns")

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Previous hunk")

        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hb", gs.blame_line, "Blame line")
      end,
    },
  },

  {
    -- keybind suggestion
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { "<leader>s", group = "[S]earch", mode = "n" },
        { "<leader>t", group = "[T]oggle", mode = "n" },
        { "<leader>h", group = "Git [H]unk", mode = "n" },
        { "gr", group = "LSP Actions", mode = "n" },
      },
    },
  },

  {
    -- fuzzy search
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },

    keys = {
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
      { "<leader>ss", "<cmd>Telescope builtin<cr>", desc = "[S]earch [S]elect Telescope" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[S]earch current [W]ord" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch by [G]rep" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]esume" },
      { "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = "[S]earch Recent Files" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "[S]earch [C]ommands" },
      { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Find existing buffers" },

      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            })
          )
        end,
        desc = "[/] Fuzzily search in current buffer",
      },

      {
        "<leader>s/",
        function()
          require("telescope.builtin").live_grep({
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
          })
        end,
        desc = "[S]earch [/] in Open Files",
      },

      {
        "<leader>sn",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("config"),
          })
        end,
        desc = "[S]earch [N]eovim files",
      },
    },

    config = function()
      local telescope = require("telescope")
      local themes = require("telescope.themes")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            themes.get_dropdown(),
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
  },

  {
    -- gruvbox
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      contrast = "soft",
      transparent_mode = false,
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}

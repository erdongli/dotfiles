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
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>h", group = "Git [H]unk", mode = "n" },
				{ "<leader>x", group = "Trouble", mode = "n" },
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
					require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
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
		-- file explorer
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file [E]xplorer" },
			{ "<leader>o", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal file in explorer" },
		},
		opts = {
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				width = 36,
			},
			renderer = {
				root_folder_label = false,
				group_empty = true,
				indent_markers = {
					enable = true,
				},
			},
			filters = {
				dotfiles = false,
			},
			git = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
			},
		},
	},

	{
		-- diagnostics and references panel
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").toggle("diagnostics")
				end,
				desc = "Toggle diagnostics",
			},
			{
				"<leader>xq",
				function()
					require("trouble").toggle("quickfix")
				end,
				desc = "Toggle quickfix",
			},
			{
				"<leader>xl",
				function()
					require("trouble").toggle("loclist")
				end,
				desc = "Toggle location list",
			},
			{
				"grr",
				function()
					require("trouble").toggle("lsp_references")
				end,
				desc = "LSP references",
			},
		},
		opts = {},
	},

	{
		-- mini plugins/modules
		"nvim-mini/mini.nvim",
		version = "*",
		config = function()
			require("mini.surround").setup()

			local statusline = require("mini.statusline")
			statusline.setup({
				use_icons = vim.g.have_nerd_font,
			})
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("hide-statusline-for-nvimtree", { clear = true }),
				pattern = { "NvimTree", "NvimTreePopup", "NvimTreeFilter" },
				callback = function(args)
					vim.b[args.buf].ministatusline_disable = true
				end,
			})
		end,
	},

	{
		-- open buffer tabs
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
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

	-- lsp
	{
		-- lspconfig
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"mason-org/mason.nvim",
				---@diagnostic disable-next-line: missing-fields
				opts = {},
			},
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local telescope = function(picker)
						return function()
							require("telescope.builtin")[picker]()
						end
					end

					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, {
							buffer = event.buf,
							desc = "LSP: " .. desc,
						})
					end

					map("grr", function()
						require("trouble").toggle("lsp_references")
					end, "[G]oto [R]eferences")
					map("gri", telescope("lsp_implementations"), "[G]oto [I]mplementation")
					map("grd", telescope("lsp_definitions"), "[G]oto [D]efinition")
					map("grt", telescope("lsp_type_definitions"), "[G]oto [T]ype Definition")
					map("gO", telescope("lsp_document_symbols"), "Open Document Symbols")
					map("gW", telescope("lsp_dynamic_workspace_symbols"), "Open Workspace Symbols")

					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gd", telescope("lsp_definitions"), "[G]oto [D]efinition")
					map("gI", telescope("lsp_implementations"), "[G]oto [I]mplementation")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Previous Diagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next Diagnostic")

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client and client.name == "ruff" then
						-- let ty handle general hover/docs for python buffers
						client.server_capabilities.hoverProvider = false
					end

					if client and client:supports_method("textDocument/documentHighlight", event.buf) then
						local supports_document_highlight = function(bufnr, exclude_client_id)
							for _, attached_client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
								if
									attached_client.id ~= exclude_client_id
									and attached_client:supports_method("textDocument/documentHighlight", bufnr)
								then
									return true
								end
							end
							return false
						end

						if not vim.b[event.buf].lsp_document_highlight_enabled then
							vim.b[event.buf].lsp_document_highlight_enabled = true

							local highlight_group_name = "lsp-highlight-" .. event.buf
							local detach_group_name = "lsp-detach-" .. event.buf
							local highlight_augroup =
								vim.api.nvim_create_augroup(highlight_group_name, { clear = true })

							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup(detach_group_name, { clear = true }),
								buffer = event.buf,
								callback = function(event2)
									vim.lsp.util.buf_clear_references(event2.buf)

									if not supports_document_highlight(event2.buf, event2.data.client_id) then
										vim.b[event2.buf].lsp_document_highlight_enabled = nil
										vim.api.nvim_clear_autocmds({
											group = highlight_group_name,
											buffer = event2.buf,
										})
										vim.api.nvim_clear_autocmds({ group = detach_group_name, buffer = event2.buf })
									end
								end,
							})
						end
					end

					if client and client:supports_method("textDocument/inlayHint", event.buf) then
						map("<leader>th", function()
							local filter = { bufnr = event.buf }
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			local servers = {
				gopls = {
					settings = {
						gopls = {
							gofumpt = true,
							usePlaceholders = true,
							completeFunctionCalls = true,
						},
					},
				},

				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
						},
					},
				},

				ruff = {},

				terraformls = {},
				tflint = {},

				ty = {
					cmd = { "ty", "server" },
				},

				lua_ls = {
					on_init = function(client)
						local path = client.workspace_folders
							and client.workspace_folders[1]
							and client.workspace_folders[1].name
						local is_nvim_config = path == vim.fn.stdpath("config")

						if client.workspace_folders then
							if
								not is_nvim_config
								and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
							then
								return
							end
						end

						local workspace_library = {
							vim.env.VIMRUNTIME,
							"${3rd}/luv/library",
							"${3rd}/busted/library",
						}

						if is_nvim_config then
							vim.list_extend(workspace_library, vim.api.nvim_get_runtime_file("lua", true))
						end

						client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							runtime = {
								version = "LuaJIT",
								path = { "lua/?.lua", "lua/?/init.lua" },
							},
							workspace = {
								checkThirdParty = false,
								library = workspace_library,
							},
						})

						client:notify("workspace/didChangeConfiguration", {
							settings = client.config.settings,
						})
					end,
					settings = {
						Lua = {},
					},
				},
			}

			local ensure_installed = {
				"gopls",
				"lua-language-server",
				"ruff",
				"rust-analyzer",
				"stylua",
				"terraform-ls",
				"tflint",
				"ty",
			}
			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				run_on_start = true,
				debounce_hours = 24,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("detach-lsp-from-nvimtree", { clear = true }),
				pattern = { "NvimTree", "NvimTreePopup", "NvimTreeFilter" },
				callback = function(args)
					for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
						vim.lsp.buf_detach_client(args.buf, client.id)
					end
				end,
			})

			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
				vim.lsp.enable(name)
			end
		end,
	},

	{
		-- autocompletion
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{
				-- snippet engine
				"L3MON4D3/LuaSnip",
				version = "2.*",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
				opts = {},
			},
		},
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
			snippets = { preset = "luasnip" },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		},
	},

	{
		-- autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					local lsp_format = vim.bo.filetype == "python" and "never" or "fallback"
					require("conform").format({ async = true, lsp_format = lsp_format })
				end,
				mode = "n",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				local filetype = vim.bo[bufnr].filetype
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = filetype == "python" and "never" or "fallback",
					}
				end
			end,
			formatters_by_ft = {
				go = { "gofmt" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				rust = { "rustfmt" },
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				["terraform-vars"] = { "terraform_fmt" },
			},
		},
	},

	{
		-- highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		parsers = {
			"bash",
			"c",
			"diff",
			"go",
			"hcl",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"rust",
			"terraform",
			"vim",
			"vimdoc",
		},
		build = function(plugin)
			require("nvim-treesitter").install(plugin.parsers, { summary = true })
		end,
		branch = "main",
		config = function(plugin)
			-- Keep configured parsers installed on normal startup too.
			require("nvim-treesitter").install(plugin.parsers, { summary = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-filetype", { clear = true }),
				callback = function(args)
					local language = vim.treesitter.language.get_lang(args.match)
					if not language then
						return
					end

					if not vim.treesitter.language.add(language) then
						return
					end

					vim.treesitter.start(args.buf, language)

					if vim.treesitter.query.get(language, "folds") then
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo.foldmethod = "expr"
						vim.wo.foldlevel = 99
					end

					if vim.treesitter.query.get(language, "indents") then
						vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
					end
				end,
			})
		end,
	},
}

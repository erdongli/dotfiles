-- [[ globals ]]
-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nerd font
vim.g.have_nerd_font = true

-- [[ options ]]
-- enable line number
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse mode
vim.opt.mouse = "a"

-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- enable true color
vim.opt.termguicolors = true

-- hide mode
vim.opt.showmode = false

-- sync clipboard
vim.opt.clipboard = "unnamedplus"

-- enable break indent
vim.opt.breakindent = true

-- persistent undo
vim.opt.undofile = true

-- case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- enable signcolumn
vim.opt.signcolumn = "yes"

-- update time / mapped sequence wait time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitution
vim.opt.inccommand = "split"

-- enable cursor line
vim.opt.cursorline = true

-- keep a few lines of context around the cursor
vim.opt.scrolloff = 5

-- show the current buffer path in the window bar
function _G.dotfiles_winbar()
	local bufnr = vim.api.nvim_get_current_buf()

	local buftype = vim.bo[bufnr].buftype
	if buftype ~= "" then
		return ""
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		return "[No Name]"
	end

	local path = vim.fn.fnamemodify(name, ":~:.")
	local flags = {}

	if vim.bo[bufnr].modified then
		table.insert(flags, "+")
	end

	if vim.bo[bufnr].readonly or not vim.bo[bufnr].modifiable then
		table.insert(flags, "RO")
	end

	if #flags == 0 then
		return " " .. path .. " "
	end

	return " " .. path .. " [" .. table.concat(flags, " ") .. "] "
end

vim.opt.winbar = "%{%v:lua.dotfiles_winbar()%}"

-- [[ keymaps ]]
-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostic
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	virtual_text = true,
	virtual_lines = false,

	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Open diagnostic [L]ocation list" })

-- disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move left"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move right"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move up"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move down"<CR>')

--  ctrl+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ autocmds ]]
-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- [[ lazy.nvim ]]
require("config.lazy")

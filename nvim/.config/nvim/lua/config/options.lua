-- enable line number
vim.opt.number = true
vim.opt.relativenumber = true

-- enable mouse mode
vim.opt.mouse = "a"

-- hide mode
vim.opt.showmode = false

-- sync clipboard
vim.opt.clipboard = "unnamedplus"

-- enable break indent
vim.opt.breakindent = true

-- enable undo/redo after reopen a file
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

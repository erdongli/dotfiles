local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	if vim.fn.executable("git") == 0 then
		vim.schedule(function()
			vim.notify("git is unavailable; skipping plugin setup", vim.log.levels.WARN)
		end)
		return
	end

	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.schedule(function()
			vim.notify("Failed to clone lazy.nvim; skipping plugin setup\n" .. out, vim.log.levels.WARN)
		end)
		return
	end
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	vim.schedule(function()
		vim.notify("Failed to load lazy.nvim; skipping plugin setup", vim.log.levels.WARN)
	end)
	return
end

lazy.setup("plugins")

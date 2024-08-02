-- Initialize header configuration
local M = {}

M.config = {
	asciiart = {
		"        :::      ::::::::",
		"      :+:      :+:    :+:",
		"    +:+ +:+         +:+  ",
		"  +#+  +:+       +#+     ",
		"+#+#+#+#+#+   +#+        ",
		"     #+#    #+#          ",
		"    ###   ########.fr    ",
	},
	start = "/*",
	finish = "*/",
	fill = "*",
	length = 80,
	margin = 5,
	types = {
		["%.c$|%.h$|%.cc$|%.hh$|%.cpp$|%.hpp$|%.php"] = { "/*", "*/", "*" },
		["%.htm$|%.html$|%.xml$"] = { "<!--", "-->", "*" },
		["%.js$"] = { "//", "//", "*" },
		["%.tex$"] = { "%", "%", "*" },
		["%.ml$|%.mli$|%.mll$|%.mly$"] = { "(*", "*)", "*" },
		["%.vim$|vimrc$"] = { '"', '"', "*" },
		["%.el$|emacs$"] = { ";", ";", "*" },
		["%.f90$|%.f95$|%.f03$|%.f$|%.for$"] = { "!", "!", "/" },
	},
}

-- Helper functions
function M.filetype()
	local f = vim.fn.expand("%:t")

	for pattern, style in pairs(M.config.types) do
		if f:match(pattern) then
			M.config.start, M.config.finish, M.config.fill = table.unpack(style)
			return
		end
	end
end

function M.ascii(n)
	return M.config.asciiart[n - 2]
end

function M.textline(left, right)
	left = left or ""
	right = right or ""
	local left_str = vim.fn.strpart(left, 0, M.config.length - M.config.margin * 2 - #right)
	return M.config.start
		.. string.rep(" ", M.config.margin - #M.config.start)
		.. left_str
		.. string.rep(" ", M.config.length - M.config.margin * 2 - #left_str - #right)
		.. right
		.. string.rep(" ", M.config.margin - #M.config.finish)
		.. M.config.finish
end

function M.line(n)
	if n == 1 or n == 11 then
		return M.config.start
			.. " "
			.. string.rep(M.config.fill, M.config.length - #M.config.start - #M.config.finish - 2)
			.. " "
			.. M.config.finish
	elseif n == 2 or n == 10 then
		return M.textline("", "")
	elseif n == 3 or n == 5 or n == 7 then
		return M.textline("", M.ascii(n))
	elseif n == 4 then
		return M.textline(vim.fn.expand("%:t"), M.ascii(n))
	elseif n == 6 then
		return M.textline(
			"By: "
				.. (vim.g.user42 or os.getenv("USER") or "marvin")
				.. " <"
				.. (vim.g.mail42 or os.getenv("MAIL") or "marvin@42.fr")
				.. ">",
			M.ascii(n)
		)
	elseif n == 8 then
		return M.textline(
			"Created: "
				.. vim.fn.strftime("%Y/%m/%d %H:%M:%S")
				.. " by "
				.. (vim.g.user42 or os.getenv("USER") or "marvin"),
			M.ascii(n)
		)
	elseif n == 9 then
		return M.textline(
			"Updated: "
				.. vim.fn.strftime("%Y/%m/%d %H:%M:%S")
				.. " by "
				.. (vim.g.user42 or os.getenv("USER") or "marvin"),
			M.ascii(n)
		)
	end
end

function M.insert()
	local l = 11
	vim.fn.append(0, "")
	while l > 0 do
		vim.fn.append(0, M.line(l))
		l = l - 1
	end
end

function M.update()
	M.filetype()
	if vim.fn.getline(9):match(M.config.start .. string.rep(" ", M.config.margin - #M.config.start) .. "Updated: ") then
		if vim.bo.modified then
			vim.fn.setline(9, M.line(9))
		end
		vim.fn.setline(4, M.line(4))
		return 0
	end
	return 1
end

function M.stdheader()
	if M.update() == 1 then
		M.insert()
	end
end

-- Set up command and keymap
vim.api.nvim_create_user_command("Stdheader", M.stdheader, {})
vim.api.nvim_set_keymap("n", "<F1>", ":Stdheader<CR>", { noremap = true, silent = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = M.update,
})

return M

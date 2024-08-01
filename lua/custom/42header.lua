-- ASCII art table
local asciiart = {
	"        :::      ::::::::",
	"      :+:      :+:    :+:",
	"    +:+ +:+         +:+  ",
	"  +#+  +:+       +#+     ",
	"+#+#+#+#+#+   +#+        ",
	"     #+#    #+#          ",
	"    ###   ########.fr    ",
}

local start = "/*"
local finish = "*/"
local fill = "*"
local length = 80
local margin = 5

local types = {
	["%.c$|%.h$|%.cc$|%.hh$|%.cpp$|%.hpp$|%.php"] = { "/*", "*/", "*" },
	["%.htm$|%.html$|%.xml$"] = { "<!--", "-->", "*" },
	["%.js$"] = { "//", "//", "*" },
	["%.tex$"] = { "%", "%", "*" },
	["%.ml$|%.mli$|%.mll$|%.mly$"] = { "(*", "*)", "*" },
	["%.vim$|vimrc$"] = { '"', '"', "*" },
	["%.el$|emacs$"] = { ";", ";", "*" },
	["%.f90$|%.f95$|%.f03$|%.f$|%.for$"] = { "!", "!", "/" },
}

local function filetype()
	local f = vim.fn.expand("%:t")

	start = "#"
	finish = "#"
	fill = "*"

	for type, val in pairs(types) do
		if f:match(type) then
			start = val[1]
			finish = val[2]
			fill = val[3]
			break
		end
	end
end

local function ascii(n)
	return asciiart[n - 2]
end

local function textline(left, right)
	left = left or "" -- Default to empty string if left is nil
	right = right or "" -- Default to empty string if right is nil
	local left_str = vim.fn.strpart(left, 0, length - margin * 2 - #right)
	return start
		.. string.rep(" ", margin - #start)
		.. left_str
		.. string.rep(" ", length - margin * 2 - #left_str - #right)
		.. right
		.. string.rep(" ", margin - #finish)
		.. finish
end

local function line(n)
	if n == 1 or n == 11 then -- top and bottom line
		return start .. " " .. string.rep(fill, length - #start - #finish - 2) .. " " .. finish
	elseif n == 2 or n == 10 then -- blank line
		return textline("", "")
	elseif n == 3 or n == 5 or n == 7 then -- empty with ascii
		return textline("", ascii(n))
	elseif n == 4 then -- filename
		return textline(vim.fn.expand("%:t"), ascii(n))
	elseif n == 6 then -- author
		return textline(
			"By: "
				.. (vim.g.user42 or os.getenv("USER") or "marvin")
				.. " <"
				.. (vim.g.mail42 or os.getenv("MAIL") or "marvin@42.fr")
				.. ">",
			ascii(n)
		)
	elseif n == 8 then -- created
		return textline(
			"Created: "
				.. vim.fn.strftime("%Y/%m/%d %H:%M:%S")
				.. " by "
				.. (vim.g.user42 or os.getenv("USER") or "marvin"),
			ascii(n)
		)
	elseif n == 9 then -- updated
		return textline(
			"Updated: "
				.. vim.fn.strftime("%Y/%m/%d %H:%M:%S")
				.. " by "
				.. (vim.g.user42 or os.getenv("USER") or "marvin"),
			ascii(n)
		)
	end
end

local function insert()
	local l = 11

	-- empty line after header
	vim.fn.append(0, "")

	-- loop over lines
	while l > 0 do
		vim.fn.append(0, line(l))
		l = l - 1
	end
end

local function update()
	filetype()
	if vim.fn.getline(9):match(start .. string.rep(" ", margin - #start) .. "Updated: ") then
		if vim.bo.modified then
			vim.fn.setline(9, line(9))
		end
		vim.fn.setline(4, line(4))
		return 0
	end
	return 1
end

local function stdheader()
	if update() == 1 then
		insert()
	end
end

-- Bind command and shortcut
vim.api.nvim_create_user_command("Stdheader", stdheader, {})
vim.api.nvim_set_keymap("n", "<F1>", ":Stdheader<CR>", { noremap = true, silent = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = update,
})

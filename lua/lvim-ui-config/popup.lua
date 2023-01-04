local utils = require("lvim-ui-config.utils")
local popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local reference = nil

local function nui_popup(title, file, ft)
	local popup_options = {
		enter = true,
		focusable = true,
		position = "50%",
		relative = "editor",
		size = {
			width = "80%",
			height = "60%",
		},
		border = {
			highlight = "NormalFloat:LvimPopupBorder",
			style = { "", " ", "", "", "", "", "", "" },
			text = {
				top = title,
				top_align = "center",
			},
		},
		buf_options = {
			filetype = ft,
		},
		win_options = {
			winhighlight = "Normal:LvimPopupNormal",
		},
	}
	reference = popup(popup_options)
	pcall(function()
		reference:mount()
		local lines = utils.readlines(file)
		vim.api.nvim_buf_set_lines(reference.bufnr, 0, 1, false, lines)
		reference:on(event.WinLeave, function()
			reference:unmount()
		end)
	end)
	return reference
end

return nui_popup

local custom_input = require("nui.input")
local event = require("nui.utils.autocmd").event
local reference = nil

local calculate_popup_width = function(default, prompt)
	local result = 40
	if prompt ~= nil then
		result = #prompt + 40
	end
	if default ~= nil then
		if #default + 40 > result then
			result = #default + 40
		end
	end
	return result
end

local function nui_input(opts, on_confirm)
	local popup_options = {
		relative = "cursor",
		position = {
			row = 1,
			col = 0,
		},
		size = {
			width = calculate_popup_width(opts.default, opts.prompt),
		},
		border = {
			highlight = "NormalFloat:LvimInputBorder",
			style = { " ", " ", " ", " ", " ", " ", " ", " " },
			text = {
				top = opts.prompt,
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:LvimInputNormal",
		},
	}
	reference = custom_input(popup_options, {
		prompt = "➤ ",
		default_value = opts.default,
		on_close = function()
			reference = nil
		end,
		on_submit = function(value)
			on_confirm(value)
			reference = nil
		end,
	})
	pcall(function()
		reference:mount()
		reference:map("n", "<esc>", reference.input_props.on_close, { noremap = true })
		reference:map("n", "q", reference.input_props.on_close, { noremap = true })
		reference:map("i", "<esc>", reference.input_props.on_close, { noremap = true })
		reference:on(event.BufLeave, reference.input_props.on_close, { once = true })
	end)
end

return nui_input

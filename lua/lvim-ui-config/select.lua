local custom_select = require("nui.menu")
local text = require("nui.text")
local event = require("nui.utils.autocmd").event
local reference = nil

local calculate_popup_width = function(entries, prompt)
	local result = 6
	for _, entry in pairs(entries) do
		if #entry.text + 6 > result then
			result = #entry.text + 6
		end
	end
	if #prompt ~= nil then
		if #prompt + 6 > result then
			result = #prompt + 6
		end
	end
	return result + 6
end

local format_entries = function(entries, formatter)
	local formatItem = formatter or tostring
	local results = {
		custom_select.separator("", {
			char = " ",
		}),
	}
	for _, entry in pairs(entries) do
		table.insert(results, custom_select.item(string.format("%s", formatItem(entry))))
	end
	return results
end

local function nui_select(entries, stuff, on_user_choice, position)
	local ui
	if position ~= "editor" then
		ui = {
			relative = "cursor",
			position = {
				row = 1,
				col = 0,
			},
		}
	else
		ui = {
			relative = "editor",
			position = "50%",
		}
	end
	local userChoice = function(choiceIndex)
		on_user_choice(choiceIndex["text"])
	end
	local formatted_entries = format_entries(entries, stuff.format_item)
	local select_options = {
		relative = ui.relative,
		position = ui.position,
		size = {
			width = calculate_popup_width(formatted_entries, stuff.prompt or "Choice:"),
			height = #formatted_entries,
		},
		border = {
			highlight = "FloatBorder:LvimSelectBorder",
			style = { " ", " ", " ", " ", " ", " ", " ", " " },
			text = {
				top = text(stuff.prompt or "Choice:", "LvimSelectBorder"),
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:LvimSelectNormal",
		},
	}
	reference = custom_select(select_options, {
		lines = formatted_entries,
		on_close = function()
			reference = nil
		end,
		on_submit = function(item)
			userChoice(item)
			reference = nil
		end,
	})
	pcall(function()
		reference:mount()
		reference:on(event.BufLeave, reference.menu_props.on_close, { once = true })
	end)
end

return nui_select

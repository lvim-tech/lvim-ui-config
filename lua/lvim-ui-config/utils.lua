local M = {}

function M.file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

function M.assert_string(n, val)
	return M.assert_arg(n, val, "string", nil, nil, 3)
end

function M.assert_arg(n, val, tp, verify, msg, lev)
	if type(val) ~= tp then
		error(("argument %d expected a '%s', got a '%s'"):format(n, tp, type(val)), lev or 2)
	end
	if verify and not verify(val) then
		error(("argument %d: '%s' %s"):format(n, val, msg), lev or 2)
	end
	return val
end

function M.readlines(file)
	M.assert_string(1, file)
	local f = io.open(file, "r")
	local res = {}
	if f ~= nil then
		for line in f:lines() do
			table.insert(res, line)
		end
		f:close()
	else
		table.insert(res, "File not exists!")
	end
	return res
end

return M

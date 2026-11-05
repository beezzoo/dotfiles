local function fmt_time(time)
	time = math.floor(time or 0)
	if time == 0 then
		return "-"
	elseif os.date("%Y", time) == os.date("%Y") then
		return os.date("%b %d %H:%M", time)
	else
		return os.date("%b %d  %Y", time)
	end
end

function Linemode:size_btime_mtime()
	local size = self._file:size()
	local size_str = size and ya.readable_size(size) or "-"

	local btime = fmt_time(self._file.cha.btime)
	local mtime = fmt_time(self._file.cha.mtime)

	return string.format("%s  c:%s  m:%s", size_str, btime, mtime)
end

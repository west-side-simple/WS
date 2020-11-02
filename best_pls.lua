-- скрапер TVS для best TV (28/09/20)

	module('best_pls', package.seeall)
	local my_src_name = 'best TV'
                      
	function GetSettings()
	 return {name = my_src_name, sortname = '', scraper = '', m3u = 'out_' .. my_src_name .. '.m3u', logo = 'https://www.pngkit.com/png/detail/248-2482291_attitude-status-hindi-best-tv-logo.png', TypeSource = 1, TypeCoding = 1, DeleteM3U = 1, RefreshButton = 0, AutoBuild = 0, AutoBuildDay = {1, 1, 1, 1, 1, 1, 1}, LastStart = 0, TVS = {add = 1, FilterCH = 1, FilterGR = 1,GetGroup = 1, LogoTVG = 1}, STV = {add = 1, ExtFilter = 1, FilterCH = 1, FilterGR = 1, GetGroup = 1, HDGroup = 1, AutoSearch = 1, AutoNumber = 1, NumberM3U = 0, GetSettings = 0, NotDeleteCH = 0, TypeSkip = 1, TypeFind = 1, TypeMedia = 0}}
	end
	function GetVersion()
	 return 2, 'UTF-8'
	end
	
	local function Load()
	local path = './luaScr/user/westSide/zapros/best.txt'
		local file = io.open('./luaScr/user/westSide/zapros/best.txt', 'r')
			if not file then
			m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path) return end
		local answer_pls = file:read('*a')
		file:close()
			answer_pls = answer_pls:gsub('\n', ' ')
		local t, i = {}, 1
		local name, adr
			for w in answer_pls:gmatch('http.-|.-|') do
				name = w:match('| (.-) |')				
				adr = w:match('(http.-) |')
					if not name or not adr then break end
				t[i] = {}
				t[i].name = name:gsub('%&amp;', '&')
				t[i].address = adr
				i = i + 1
			end
				if i == 1 then return end				
	 return t
	end
	function GetList(UpdateID, m3u_file)
			if not UpdateID then return end
			if not m3u_file then return end
			if not TVSources_var.tmp.source[UpdateID] then return end
		local Source = TVSources_var.tmp.source[UpdateID]
		local t_pls = Load()
		if not t_pls then m_simpleTV.OSD.ShowMessageT({text = Source.name .. ' - ошибка загрузки плейлиста', color = ARGB(255, 255, 0, 0), showTime = 1000 * 5, id = 'channelName'}) return end
		local m3ustr = tvs_core.ProcessFilterTable(UpdateID, Source, t_pls)
		local handle = io.open(m3u_file, 'w+')
			if not handle then return end
		handle:write(m3ustr)
		handle:close()
	 return 'ok'
	end	
-- debug_in_file(#t_pls .. '\n')
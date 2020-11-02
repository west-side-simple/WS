-- скрапер TVS для плейлиста ТВ каналов сайта https://wink.rt.ru/tv от west_side (20/10/20)

	module('wink_portal_pls', package.seeall)
	local my_src_name = 'PORTAL Wink TV'
	local wink_site = 'https://wink.rt.ru/tv/'
	function GetSettings()
	 return {name = my_src_name, sortname = '', scraper = '', m3u = 'out_' .. my_src_name .. '.m3u', logo = '..\\Channel\\logo\\extFiltersLogo\\wink.png', TypeSource = 1, TypeCoding = 1, DeleteM3U = 0, RefreshButton = 0, AutoBuild = 0, AutoBuildDay = {0, 0, 0, 0, 0, 0, 0}, LastStart = 0, TVS = {add = 0, FilterCH = 0, FilterGR = 0,GetGroup = 0, LogoTVG = 0}, STV = {add = 1, ExtFilter = 1, FilterCH = 0, FilterGR = 0, GetGroup = 1, HDGroup = 0, AutoSearch = 1, AutoNumber = 1, NumberM3U = 1, GetSettings = 1, NotDeleteCH = 0, TypeSkip = 1, TypeFind = 1, TypeMedia = 3}}
	end

	function GetVersion()
	 return 2, 'UTF-8'
	end
	local sessionWink = m_simpleTV.Http.New('Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36', prx, true)
			if not sessionWink then return end
			m_simpleTV.Http.SetTimeout(sessionWink, 12000)
	local function LoadFromPages()
	local t, page, i = {}, 1, 1
	while page <= 1000 do
			local wink_url = wink_site .. page
			local rc, wink_answer = m_simpleTV.Http.Request(sessionWink, {url = wink_url})
			if rc == 200 then	
				t[i] = {}
				t[i].logo = wink_answer:match('property="og:image" content="(.-)"')
				t[i].name = wink_answer:match('<h1 class="root_r1ru04lg title_t1kbub20 root_header1_r1swja1w" data%-test="media%-item%-name">(.-)<')
				t[i].name = t[i].name:gsub('&quot;', '"'):gsub('&amp;', '&'):gsub('5 канал', '5 канал Россия')
				t[i].address = wink_url
				t[i].RawM3UString = 'catchup="append" catchup-days="3" catchup-source="?offset=-${offset}&utcstart=${timestamp}" catchup-record-source="?utcstart=${start}&utcend=${end}"'
				t[i].group = wink_answer:match('<h3 class="root_r1ru04lg subtitle.-">(.-)<') or 'Wink TV'
				if t[i].name == 'Супер' then t[i].group = 'Эфирные, Кино и сериалы, Развлекательные' end
				t[i].group_logo = './luaScr/user/westSide/genres_tv/' .. t[i].group:gsub(',.-$', '') .. '.png'						                                
                t[i].group_is_unique = 1
				m_simpleTV.OSD.ShowMessageT({text = wink_url, showTime = 1000 * 60})
			    i = i + 1
				page = page + 1
				else page = page + 1
			end
			end
	 return t
	end

	function GetList(UpdateID, m3u_file)
			if not UpdateID then return end
			if not m3u_file then return end
			if not TVSources_var.tmp.source[UpdateID] then return end
		local Source = TVSources_var.tmp.source[UpdateID]
		local t_pls = LoadFromPages()
			if not t_pls then m_simpleTV.OSD.ShowMessageT({text = Source.name .. ' - ошибка загрузки плейлиста', color = ARGB(255, 255, 0, 0), showTime = 1000 * 5, id = 'channelName'}) return end
		local m3ustr = tvs_core.ProcessFilterTable(UpdateID, Source, t_pls)
		local handle = io.open(m3u_file, 'w+')
			if not handle then return end
		handle:write(m3ustr)
		handle:close()
	 return 'ok'
	end
-- debug_in_file(#t_pls .. '\n')
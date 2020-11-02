-- скрапер TVS для просмотра коллекций медиа сайта https://wink.rt.ru от west_side (01/11/20)
		local masshtab = m_simpleTV.User.paramScriptForSkin_masshtab or 1
		if m_simpleTV.User.paramScriptForSkin_background1 then
			background1 = m_simpleTV.User.paramScriptForSkin_background1
		else
			background1 = ''
		end
		if m_simpleTV.User.paramScriptForSkin_background2 then
			background2 = m_simpleTV.User.paramScriptForSkin_background2
		else
			background2 = ''
		end
		local titul_rezka = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag\')"><img src="https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_hevc = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/h265.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_rezka_tor = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="https://rezka.cc/apple-touch-icon.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/new\/\')"><img src="https://www.lostfilm.tv/favicon.ico" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_yt = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.youtube.com/feed/channels\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_wink = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuWINK.png" height="' .. 36*masshtab .. '" align="top"></a>'
---------------------------------------------------------------------------
	module('wink_collection_pls', package.seeall)
	local my_src_name = 'Wink Collection'
	local wink_site = 'https://wink.rt.ru/collections/'
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
	local t, page, i, k = {}, 1, 1, 1
	while page <= 1025 do
			local wink_url = wink_site .. page .. '?category_id=17'
			local rc, wink_answer = m_simpleTV.Http.Request(sessionWink, {url = wink_url})
			if rc == 200 then	
				t[i] = {}
				t[i].logo = wink_answer:match('loading="lazy" srcSet="(.-) 2x"')
				t[i].name = wink_answer:match('<title data%-rh=.->(.-)<')
				t[i].name = t[i].name:gsub(' смотреть онлайн в хорошем качестве 1080p.-$', '')
				t[i].address = wink_url
				t[i].video_desc = ''
				t[i].video_title = 'Состав сборника'
				t[i].group = 'Сборники'
				if t[i].name then
				local pars, j, kj = {}, 1, 1
					for media in wink_answer:gmatch('<a data%-type="media_item"(.-)</a>') do
					pars[j] = {}
					pars[j].poster = media:match('loading="lazy" srcSet="(.-) 2x"')
					pars[j].adr = media:match('href="(.-)"')
					pars[j].adr = 'https://wink.rt.ru' .. pars[j].adr
					pars[j].rating = media:match('<div class="ratings_r1x6jaa5">(.-)</div>')
					pars[j].rating = tonumber(pars[j].rating)
					if not pars[j].rating or pars[j].rating == '' then pars[j].rating = 0 end
					pars[j].name1 = media:match('<h4 class="root_r1ru04lg.-">(.-)</h4>')
					if kj == 7 then
						t[i].video_desc = t[i].video_desc .. '</tr><tr>' kj = 1
					end				
					t[i].video_desc = t[i].video_desc .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*150 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. pars[j].adr ..
					'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. pars[j].poster .. '" height = "' .. 210*masshtab .. '" width = "' .. 140*masshtab ..
					'"><h5><center><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. pars[j].rating .. '.png" height="' .. masshtab*24 .. 
					'" align="top"></h5><h5><center><font color=#00FA9A>' .. pars[j].name1 .. '</font></h5></a></td>'
					j = j + 1
					kj = kj + 1
					end
					if t[i].video_desc ~= '' then
					t[i].video_desc = '<html><body bgcolor="#434750" ' .. background1 .. '><table width="' .. masshtab*960 .. 
					'"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><h3><center>' .. titul_rezka_tor .. titul_hevc .. titul_lostfilm .. titul_yt .. titul_rezka .. titul_wink ..
					'</h3></td></tr></table><hr><table width="' .. masshtab*960 .. '"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><h1><center><font color=#6495ED>' .. t[i].name .. 
					'</h1></td></tr></table><table width="' .. masshtab*960 .. '"><tr>' .. t[i].video_desc .. '</td></tr></table></body></html>'
					end
					t[i].video_desc = t[i].video_desc:gsub('"', '%%22')
					k = k + 1
					m_simpleTV.OSD.ShowMessageT({text = k - 1 .. '. ' .. t[i].name, showTime = 1000 * 60})
				end
				i = i + 1
				page = page + 1
				else page = page + 1
			end
			end

			local tab, i = {}, 1
			for i = 1, #t do
				if t[i].video_desc ~= '' and not t[i].name:match('удиокниги') then
				tab[#tab + 1] = t[i]
			end
			end
	 return tab
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
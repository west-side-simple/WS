-- скрапер TVS для https://itv.rt.ru (26/10/20) - UFC
---------------------------------------------------------------------------
		local package_id = '1000'
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
	module('Z_ufc_pls', package.seeall)
	local my_src_name = '🎦 UFC'
	function GetSettings()
		local scrap_settings = {name = my_src_name, sortname = '', scraper = '', m3u = 'out_' .. my_src_name .. '.m3u', logo = 'https://s26037.cdn.ngenix.net/sdp/ct/nclogo1555518558281.png', TypeSource = 1, TypeCoding = 1, DeleteM3U = 0, RefreshButton = 0, AutoBuild = 0, show_progress = 1, AutoBuildDay = {0, 0, 0, 0, 0, 0, 0}, LastStart = 0, TVS = {add = 0, FilterCH = 0, FilterGR = 0,GetGroup = 0, LogoTVG = 0}, STV = {add = 1, ExtFilter = 0, FilterCH = 0, FilterGR = 0, GetGroup = 1, HDGroup = 0, AutoSearch = 0, AutoNumber = 0, NumberM3U = 0, GetSettings = 1, NotDeleteCH = 0, TypeSkip = 1, TypeFind = 1, TypeMedia = 3}}
	 return scrap_settings
	end
	function GetVersion()
	 return 2, 'UTF-8'
	end
	
			

	local function LoadFromAnswer()

		require 'json'

		local session = m_simpleTV.Http.New('Mozilla/5.0 (SmartHub; SMART-TV; U; Linux/SmartTV) AppleWebKit/531.2+ (KHTML, like Gecko) WebBrowser/1.0 SmartTV Safari/531.2+')
			if not session then return end
		m_simpleTV.Http.SetTimeout(session, 300000)
		local rc, answer = m_simpleTV.Http.Request(session, {url = decode64('aHR0cHM6Ly9mZS5zdmMuaXB0di5ydC5ydS9DYWNoZUNsaWVudEpzb24vanNvbi9Wb2RQYWNrYWdlL2xpc3RfbW92aWVzP2xvY2F0aW9uSWQ9NzAwMDAxJmZyb209MCZ0bz05OTk5OTk5OSZwYWNrYWdlSWQ9') .. package_id})
--		m_simpleTV.Http.Close(session)
			if rc ~= 200 then return end
		answer = answer:gsub('%[%]', '""')
		local tab = json.decode(answer)
			if not tab or not tab.movie_list then return end
		local t, i = {}, 1
		local j = 1
			while true do
					if not tab.movie_list[j] then break end
				if tab.movie_list[j].assets and tab.movie_list[j].assets.ott_content_asset and tab.movie_list[j].assets.ott_content_asset.ifn and tab.movie_list[j].assets.ott_content_asset.ifn ~= ''
				and (tab.movie_list[j].name:match('Golden Boy')
				or tab.movie_list[j].name:match('Matchroom')
				or tab.movie_list[j].assets.ott_content_asset.ifn:match('_ufc_')
				or tab.movie_list[j].assets.ott_content_asset.ifn:match('_UFC_')
				or tab.movie_list[j].assets.ott_content_asset.ifn:match('vremya_derzkih')
				or tab.movie_list[j].assets.ott_content_asset.ifn:match('luchshie_nokauty')
				or tab.movie_list[j].assets.ott_content_asset.ifn:match('_boxing_'))
				and not tab.movie_list[j].name:match('Brooklyn')
				then
					t[i] = {}
					t[i].address = tab.movie_list[j].assets.ott_content_asset.ifn
					t[i].name = tab.movie_list[j].name
					t[i].logo = tab.movie_list[j].logo2 or './luaScr/user/westSide/icons/DefaultVideo.png'
					t[i].logo_desc = tab.movie_list[j].logo or './luaScr/user/westSide/icons/DefaultVideo.png'
					t[i].ageLevel = tab.movie_list[j].ageLevel or ''
					t[i].years = tab.movie_list[j].year or ''

					k = 1
				    bundles = ''
					while true do
						if not (tab.movie_list[j].bundles and tab.movie_list[j].bundles[k]) then break end
						bundlestmp = tostring (tab.movie_list[j].bundles[k])
						if k == 1 then bundles = bundlestmp .. bundles else
						bundles = bundlestmp .. ', ' .. bundles end
						k = k + 1
					end
						if bundles ~= ''
						then t[i].group1 = bundles
						else t[i].group1 = ''
						end
					i = i + 1
				end
				m_simpleTV.OSD.ShowMessageT({text = 'WINK: in (' .. j .. ') out (' .. i .. ')' ,0xFF00,3})
				j = j + 1
			end

			if i == 1 then return end
		local hash, tab = {}, {}
			for i = 1, #t do
				if not hash[t[i].address]
				then
					tab[#tab + 1] = t[i]
					hash[t[i].address] = true
				end
			end

			if #tab == 0 then return end

			for i = 1, #tab do
			    tab[i].address = tab[i].address:gsub('%.ts$', '/variant.m3u8')
				tab[i].address = tab[i].address:gsub('%.wvm$', '/variant.m3u8')
				tab[i].address = 'https://zabava-htvod.cdn.ngenix.net/hls/' .. tab[i].address

				if tab[i].logo then
					tab[i].logo = 'http://sdp.svc.iptv.rt.ru:8080/images/' .. tab[i].logo
				end

				if tab[i].logo_desc then
					tab[i].logo_desc = 'http://sdp.svc.iptv.rt.ru:8080/images/' .. tab[i].logo_desc
				end

				if tab[i].ageLevel == '1000298' then
					tab[i].ageLevel = '18+'
				elseif tab[i].ageLevel == '1000297' then
					tab[i].ageLevel = '16+'
				elseif tab[i].ageLevel == '52653' then
					tab[i].ageLevel = '12+'
				elseif tab[i].ageLevel == '10758' then
					tab[i].ageLevel = '6+'
				elseif tab[i].ageLevel == '3' or tab[i].ageLevel == '' then
					tab[i].ageLevel = '0+'
				end

				tab[i].video_title = tab[i].years .. ' | ' .. tab[i].ageLevel

				tab[i].name = tab[i].name:gsub(',', '%%2C')

				tab[i].video_desc = '<html><body bgcolor="#434750" ' .. background2 .. '><table width="' .. masshtab*600 .. '"><tr><td style="padding: 10px 10px 5px;"><img src="' .. tab[i].logo_desc ..
					'" width="' .. masshtab*200 .. '"></td><td style="padding: 0px 5px 10px; color: #EBEBEB; vertical-align: middle;"><h3><center>' .. titul_rezka_tor .. titul_hevc .. titul_lostfilm .. titul_yt .. titul_rezka .. titul_wink ..
					'</h3><hr><h3>' .. tab[i].name .. '</h3><h4><font color=#D2691E><i>• Возрастное ограничение: </i>' .. tab[i].ageLevel .. '</font></h4><h3>' .. tab[i].years .. '</h3></td></tr></table></body></html>'

				tab[i].video_desc = tab[i].video_desc:gsub('"', '%%22')
			
			end
			
			table.sort(tab, function(a, b) return a.group1 < b.group1 end)

			for i = 1, #tab do	

				if i == 1 
				then
					local rc, answer_page = m_simpleTV.Http.Request(session, {url = 'https://wink.rt.ru/media_items/' .. tab[i].group1})
					if rc ~= 200 then return end
					m_simpleTV.Http.SetTimeout(session, 12000)	
					if answer_page then
						tab[i].group_logo = answer_page:match('<div class="poster_p1uq546i">.-src="(.-)"')
						tab[i].group = answer_page:match('data%-test="media%-item%-name">(.-)<')
						tab[i].video_title1 = answer_page:match('<div data%-test="media%-item%-description".->(.-)<') or ''
						tab[i].video_title = tab[i].video_title .. ' | ' .. tab[i].video_title1
					end
				else
					if tab[i].group1 == tab[i - 1].group1
					then
					tab[i].group = tab[i - 1].group
					tab[i].group_logo = tab[i - 1].group_logo
					tab[i].video_title = tab[i - 1].video_title
					else
						local rc, answer_page = m_simpleTV.Http.Request(session, {url = 'https://wink.rt.ru/media_items/' .. tab[i].group1})
						if rc ~= 200 then return end
						m_simpleTV.Http.SetTimeout(session, 12000)	
						if answer_page then
							tab[i].group_logo = answer_page:match('<div class="poster_p1uq546i">.-src="(.-)"')
							tab[i].group = answer_page:match('data%-test="media%-item%-name">(.-)<')
							tab[i].video_title1 = answer_page:match('<div data%-test="media%-item%-description".->(.-)<') or ''
							tab[i].video_title = tab[i].video_title .. ' | ' .. tab[i].video_title1
						end
				
					end
				end
				m_simpleTV.OSD.ShowMessageT({text = tab[i].group, color = ARGB(255, 255, 63, 127), showTime = 1000 * 60})
				i = i + 1
				
				end
			
	 return tab
	end
	function GetList(UpdateID, m3u_file)
			if m_simpleTV.Common.GetVlcVersion() < 3000 then return end
			if not UpdateID then return end
			if not m3u_file then return end
			if not TVSources_var.tmp.source[UpdateID] then return end
		local Source = TVSources_var.tmp.source[UpdateID]
		local t_pls = LoadFromAnswer()
			if not t_pls then
				m_simpleTV.OSD.ShowMessageT({text = Source.name .. ' - ошибка загрузки плейлиста', color = ARGB(255, 255, 0, 0), showTime = 1000 * 5, id = 'channelName'})
			 return
			end
		local m3ustr = tvs_core.ProcessFilterTable(UpdateID, Source, t_pls)
		local handle = io.open(m3u_file, 'w+')
			if not handle then
			 return nil
			end
		handle:write(m3ustr)
		handle:close()
	 return 'ok'
	end
-- debug_in_file(#t_pls .. '\n')
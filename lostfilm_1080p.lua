-- видеоскрипт для сайта http://www.lostfilm.tv (19/09/20)
-- авторы nexterr, west_side
-- необходим: Acestream
-- логин, пароль установить в 'Password Manager', для id - lostfilm
-- открывает подобные ссылки:
-- https://www.lostfilm.tv/series/Counterpart
-- https://www.lostfilm.tv/series/Star_Trek_Discovery/seasons/
-- https://www.lostfilm.tv/series/Game_of_Thrones/season_8
-- https://www.lostfilm.tv/series/American_Horror_Story/season_6/episode_10/
-- http://n.tracktor.site/td.php?s=FhI7t4 ...
-- http://www.lostfilm.tv/series/The_Night_Manager
-- http://www.lostfilm.tv/series/The_Punisher/video/2
-- ## прокси ##
local prx = ''
	local titul_rezka = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag\')"><img src="https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png" height="54" align="top"></a>'
	local titul_hevc = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/h265.png" height="54" align="top"></a>'
	local titul_rezka_tor = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="https://rezka.cc/apple-touch-icon.png" height="54" align="top"></a>'
	local titul_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/new\/\')"><img src="https://www.lostfilm.tv/favicon.ico" height="54" align="top"></a>'
	local titul_yt = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.youtube.com/feed/channels\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="54" align="top"></a>'
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
		if m_simpleTV.User.paramScriptForSkin_background_chanel then
			background_chanel = m_simpleTV.User.paramScriptForSkin_background_chanel
		else
			background_chanel = 'https://radio-stream-1.obozrevatel.com/radiorelaxfm128.mp3'
		end	
-- '' - нет
--  'https://proxy-nossl.antizapret.prostovpn.org:29976' (пример)
-- ##
		if m_simpleTV.Control.ChangeAdress ~= 'No' then return end
	local inAdr = m_simpleTV.Control.CurrentAdress
		if not inAdr then return end
		if not inAdr:match('^https?://www.lostfilm%.tv/')
			and not inAdr:match('https?://n%.tracktor%.')
			and not inAdr:match('&lostfilm')
			and not inAdr:match('^https?://store%.bogi%.ru')
		then
		 return
		end
	if not m_simpleTV.User then
		m_simpleTV.User = {}
	end
	if not m_simpleTV.User.lostfilm then
		m_simpleTV.User.lostfilm = {}
	end
	m_simpleTV.Control.ChangeAdress = 'Yes'
	m_simpleTV.Control.CurrentAdress = ''
		if inAdr:match('https?://n%.tracktor%.') then
			local title = 'lostfilm'
			if inAdr:match('%$TORRENTINDEX=%d') and m_simpleTV.User.lostfilm.title then
				title = m_simpleTV.User.lostfilm.title
			end
			if m_simpleTV.Control.CurrentTitle_UTF8 then
				m_simpleTV.Control.CurrentTitle_UTF8 = title
			end
			local posterUrl = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg'
			if inAdr:match('%$TORRENTINDEX=%d') and m_simpleTV.User.lostfilm.posterUrl then
				posterUrl = m_simpleTV.User.lostfilm.posterUrl
			end
			m_simpleTV.Interface.SetBackground({BackColor = 0, BackColorEnd = 255, PictFileName = posterUrl, TypeBackColor = 0, UseLogo = 3, Once = 1})
			local retAdr = 'torrent://' .. inAdr:gsub('^torrent://', '')
			m_simpleTV.Control.CurrentAdress = retAdr
		 return		
		end
	local title
	if m_simpleTV.User.lostfilm.Tabletitle then
		local index = m_simpleTV.Control.GetMultiAddressIndex()
		if index then
			title = m_simpleTV.User.lostfilm.title .. ' - '
			.. m_simpleTV.User.lostfilm.Tabletitle[index].Name
		end
	end
		if inAdr:match('%.bogi%.ru') then
			m_simpleTV.OSD.ShowMessageT({text = title, color = ARGB(255, 155, 155, 255), showTime = 1000 * 5, id = 'channelName'})
			m_simpleTV.Control.CurrentAdress = inAdr .. '$OPT:NO-STIMESHIFT'
			if m_simpleTV.Control.CurrentTitle_UTF8 then
				m_simpleTV.Control.CurrentTitle_UTF8 = title
			end
		 return
		end
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 1000, id = 'channelName'})
	m_simpleTV.Interface.SetBackground({BackColor = 0, BackColorEnd = 255, PictFileName = '', TypeBackColor = 0, UseLogo = 3, Once = 1})
	if not m_simpleTV.User.lostfilm.qlty then
		m_simpleTV.User.lostfilm.qlty = tonumber(m_simpleTV.Config.GetValue('lostfilm_qlty') or '3')
	end
	local session = m_simpleTV.Http.New('Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3729.108 Safari/537.36', prx, false)
		if not session then return end
	m_simpleTV.Http.SetTimeout(session, 12000)
	local function trim(str)
		str = string.match(str,'^%s*(.-)%s*$')
	 return str
	end
		if inAdr:match('/series/.-/video') then
			m_simpleTV.User.lostfilm.Tabletitle = nil
			m_simpleTV.User.lostfilm.title = nil
			local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr})
			m_simpleTV.Http.Close(session)
				if rc ~= 200 then
					m_simpleTV.OSD.ShowMessageT({text = 'lostfilm ошибка[0.1]-' .. rc, color = ARGB(255, 255, 0, 0), showTime = 5000, id = 'channelName'})
				 return
				end
			local t, i = {}, 1
			local name = answer:match('<div class="title">(.-)</div>') or 'lostfilm'
			name = 'Видео: ' .. name
			m_simpleTV.User.lostfilm.title = name
			local adr, desc, quality
				for w in answer:gmatch('<div class="video%-block video_block">(.-)<div class="hor') do
					desc = w:match('<div class="description">(.-)</div>')
					adr = w:match('data%-src="(.-)"')
						if not adr or not desc then break end
					t[i] = {}
					t[i].Id = i
					desc = desc:gsub('LostFilm%.TV', '')
					quality = w:match('data%-quality="(.-)"') or ''
					if quality:match('480p') then
						adr = adr:gsub('360p', '480p')
					end
					if quality:match('720p') then
						adr = adr:gsub('480p', '720p')
					end
					if quality:match('1080p') then
						adr = adr:gsub('720p', '1080p')
					end
					t[i].Name = trim(desc)
					t[i].Adress = adr
					i = i + 1
				end
				if i == 1 then return end
			if i > 2 then
				t.ExtParams = {FilterType = 2, AutoNumberFormat = '%1. %2'}
				local _, id = m_simpleTV.OSD.ShowSelect_UTF8(name, 0, t, 5000)
				if not id then
					id = 1
				end
				retAdr = t[id].Adress
				name = name .. ' - ' .. t[id].Name
				m_simpleTV.User.lostfilm.Tabletitle = t
			else
				retAdr = t[1].Adress
				name = name .. ' - ' .. t[1].Name
			end
			m_simpleTV.Control.CurrentAdress = retAdr
			if m_simpleTV.Control.CurrentTitle_UTF8 then
				m_simpleTV.Control.CurrentTitle_UTF8 = name
			end
			m_simpleTV.OSD.ShowMessageT({text = name, color = ARGB(255, 155, 155, 255), showTime = 1000 * 5, id = 'channelName'})
		 return		 
		end
	if not m_simpleTV.User.lostfilm.cooki then
		m_simpleTV.User.lostfilm.cooki = m_simpleTV.Config.GetValue('lostfilm_reg') or ''
	end
	local retAdr = inAdr
	local host = retAdr:match('https?://.-/')
	local function GetMaxResolutionIndex(t)
		local index
		for u = 1, #t do
				if t[u].qlty and m_simpleTV.User.lostfilm.qlty < t[u].qlty then break end
			index = u
		end
	 return index or 1
	end
	function GetMovieQuality()
		local t = m_simpleTV.User.lostfilm.ResolutionTable
			if not t then return end
		local index = m_simpleTV.User.lostfilm.Index
		t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		if #t > 1 then
			local ret, id = m_simpleTV.OSD.ShowSelect_UTF8('⚙ Качество', index-1, t, 5000, 1 + 4 + 2)
			if ret == 1 then
				m_simpleTV.User.lostfilm.Index = id
				m_simpleTV.User.lostfilm.qlty = t[id].qlty
				m_simpleTV.Control.SetNewAddress(t[id].Adress, m_simpleTV.Control.GetPosition())
				m_simpleTV.Config.SetValue('lostfilm_qlty', t[id].qlty)
			end
		end
	end
	local function GetLostfilmAddress(answer)
		local t, i = {}, 1
		local name, Adr, siz, sdhd
			for name, Adr, siz in answer:gmatch('<div class="inner%-box%-%-label">(.-)<.- href="(.-)".-box%-%-desc"(.-)</div>') do
					if not name or not Adr then break end
				siz = siz:match('Размер: (.-)%. Перевод')
				sdhd = name:gsub('[\r\n]', '')
				name = name:gsub('[\r\n]', ' '):gsub('SD', 'низкое'):gsub('HD', 'среднее'):gsub('MP4', 'среднее'):gsub('1080', 'высокое')
				if siz then
					name = name .. ' (' .. sdhd .. '  ' .. siz .. ')'
				end
				t[i] = {}
				t[i].Name = name:gsub('%s%s*', ' ')
				t[i].Adress = 'torrent://' .. Adr
				if name:match('низкое') then
					t[i].qlty = 1
				elseif name:match('среднее') then
					t[i].qlty = 2
				elseif name:match('высокое') then
					t[i].qlty = 3
				else
					t[i].qlty = 4
				end
				i = i + 1
			end
			if i == 1 then return end
		table.sort(t, function(a, b) return a.qlty < b.qlty end)
			for i = 1, #t do
				t[i].Id = i
				t[i].qlty = i
				if t[i].qlty == 1 then
					t[i].Name = t[i].Name:gsub('среднее', 'низкое'):gsub('высокое', 'низкое')
				elseif t[i].qlty == 2 then
					t[i].Name = t[i].Name:gsub('низкое', 'среднее'):gsub('высокое', 'среднее')
				elseif t[i].qlty == 3 then
					t[i].Name = t[i].Name:gsub('низкое', 'высокое'):gsub('среднее', 'высокое')
				end
			end
		local retAdr
		m_simpleTV.User.lostfilm.ResolutionTable = t
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			t.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		else
			t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		end	
		local index = GetMaxResolutionIndex(t)
		m_simpleTV.User.lostfilm.Index = index
			if not answer:match('<div class="inner%-box%-%-text">.-серия') and not answer:match('<div class="inner%-box%-%-text">.-Дополнительные материалы') then
				if i > 2 then
--					t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕'}
					local ret, id = m_simpleTV.OSD.ShowSelect_UTF8('⚙ Качество', index-1, t, 5000, 1 + 4 + 2)
					if not id then
						id = index
					end	
					if ret == 1 then
						m_simpleTV.User.lostfilm.qlty = t[id].qlty
						m_simpleTV.Config.SetValue('lostfilm_qlty', t[id].qlty)
					end
					retAdr = t[id].Adress
				else
					retAdr = t[1].Adress
				end
				title = m_simpleTV.User.lostfilm.title
			 return retAdr, true
			end
		retAdr = t[index].Adress
	 return retAdr
	end
	local function GetLostfilmCookie(Adr)
		local error_text, pm = pcall(require, 'pm')
			if not package.loaded.pm then return end
		local ret, login, pass = pm.GetTestPassword('lostfilm', 'LostFilm', false)
			if not login or not pass or login == '' or pass == '' then return end
		local url = host .. 'ajaxik.php'
		local rc, answer = m_simpleTV.Http.Request(session, {url = url, method = 'post', body = 'act=users&type=login&mail=' .. url_encode(login) .. '&pass=' .. url_encode(pass) .. '&need_captcha=&captcha=&rem=1', headers = 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8\nReferer: https://www.lostfilm.tv/new_pass/'})
			if rc ~= 200 then return end
		local cooki = m_simpleTV.Http.GetCookies(session, url, '')
			if not cooki then return end
		rc, answer = m_simpleTV.Http.Request(session, {url = Adr})
			if rc ~= 200 then return end
		m_simpleTV.User.lostfilm.cooki = cooki
		m_simpleTV.Config.SetValue('lostfilm_reg', m_simpleTV.User.lostfilm.cooki)
	 return answer
	end
	if not retAdr:match('&lostfilm') and not retAdr:match('lostfilm%.tv%/new') then
		m_simpleTV.User.lostfilm.Tabletitle = nil
		m_simpleTV.User.lostfilm.title = nil
		m_simpleTV.User.lostfilm.posterUrl = nil
		if not retAdr:match('/season') then
			retAdr = retAdr .. '/seasons'
		end
		retAdr = retAdr:gsub('^(.+series/.-/.-/.-/).+', '%1')
		local host = retAdr:match('https?://.-/')
		m_simpleTV.Http.SetCookies(session, retAdr, '', m_simpleTV.User.lostfilm.cooki)
		local rc, answer = m_simpleTV.Http.Request(session, {url = retAdr})
			if rc ~= 200 then
				m_simpleTV.Http.Close(session)
				m_simpleTV.OSD.ShowMessageT({text = 'lostfilm ошибка[1]-' .. rc, color = ARGB(255, 255, 0, 0), showTime = 5000, id = 'channelName'})
			 return
			end
		if answer:match('<a href="/login"') then
			answer = GetLostfilmCookie(retAdr)
				if not answer then
					m_simpleTV.Http.Close(session)
					m_simpleTV.OSD.ShowMessageT({text = 'Для LostFilm нужен логин и пароль\n\nlostfilm ошибка[1.1]', color = ARGB(255, 255, 0, 0), showTime = 5000, id = 'channelName'})
				 return
				end
		end
		title = answer:match('<title>(.-)</title>') or 'lostfilm'
		title = title:gsub(':.+', ''):gsub('%(.-%)', ''):gsub('Гид по.+', ''):gsub('%s%s+', ' '):gsub('%s%.', '.'):gsub('%.', '')
		m_simpleTV.User.lostfilm.title = title
		local sesons_list = answer:match('<div class="left%-part".-<div class="select%-box".-(</option>.-</select>)')
		local sesons_name = ''
		if sesons_list and not retAdr:match('/season%W') and not retAdr:match('/episode%w') then
			local rc, answer0 = m_simpleTV.Http.Request(session, {url = retAdr:gsub('/season.-$', '')})
			answer0 = answer0 or ''
			local poster_ser = answer0:match('rel=\'image_src\' href="(.-)"') or 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg'
			local t, i = {}, 1
			local name, adr
				for s in sesons_list:gmatch('option value=.-</option>') do
					name = s:match('>(.-)<')
					adr = s:match('value="(.-)"')
						if not name or not adr then break end
					t[i] = {}
					t[i].Id = i
					if not name:match('Дополнительные материалы') then
						name = name .. ' сезон'
					end
					t[i].Name = name
					t[i].Adress = retAdr:gsub('/seasons.-$', '') .. '/' .. adr
					t[i].InfoPanelLogo = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg'
					t[i].InfoPanelShowTime = 10000
					t[i].InfoPanelName = title
					t[i].InfoPanelTitle = name
					i = i + 1
				end
			if i > 2 then
				m_simpleTV.Interface.SetBackground({BackColor = 0, BackColorEnd = 255, PictFileName = poster_ser, TypeBackColor = 0, UseLogo = 3, Once = 1})
				t.ExtParams = {FilterType = 2}
				m_simpleTV.Control.SetTitle(title)
				local _, id = m_simpleTV.OSD.ShowSelect_UTF8(title, 0, t, 10000, 1 + 2)
				if not id then
					id = 1
				end
				retAdr = t[id].Adress
				sesons_name = ' - ' .. t[id].Name
				rc, answer = m_simpleTV.Http.Request(session, {url = retAdr})
					if rc ~= 200 then
						m_simpleTV.Control.CurrentAdress = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg$OPT:image-duration=10'
						m_simpleTV.Http.Close(session)
						m_simpleTV.OSD.ShowMessageT({text = 'lostfilm ошибка[2]-' .. rc, color = ARGB(255, 255, 0, 0), showTime = 5000, id = 'channelName'})
					 return
					end
				m_simpleTV.Control.ExecuteAction(37)
			end
		end
		title1 = answer:match('<title>(.-)</title>')
		title1 = title1:gsub('%: кадры%, фото%, актеры%, персонажи и съемочная группа%, обсуждение эпизода.-$', ''):gsub('%. %- LostFilm%.TV%.', '')
		title1 = title1:gsub('%. ', '<p>'):gsub(', ', ' - ')
		local a1, j = {}, 1
		local name, c, s, e
			for ww in answer:gmatch('markEpisodeAsWatched.-</tr>') do
				left_str, right_str = '', ''
				name = ww:match('<h1 class="title%-ru">(.-)</h1>') or ww:match('<div>(.-)<') or ''
				c, s, e = ww:match('data%-code=\"(%d+)%-(%d+)%-(%d+)\"')
					if not c or not s or not e then break end
				if s == '999' then
					name = e .. '. ' .. name:gsub('[\r\n]', '')
				else
					name = s .. ' сезон ' .. e .. ' серия - ' .. name:gsub('[\r\n]', '')
				end
				poster = ww:match('<div style="background:url%(\'(.-)\'%)%;"')
				if poster then poster = 'https:' .. poster else
				poster = 'https://static.lostfilm.tv/Images/' .. c .. '/Posters/e_' .. s .. '_' .. e .. '.jpg' end
				for ww1 in answer:gmatch('<a.-</a>') do
				if ww1:match('<div class="previous%-link active">') then 
				left_str = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. host .. ww1:match('<a href="(.-)">') .. '\')">'
				end
				if ww1:match('<div class="next%-link active">') then 
				right_str = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. host .. ww1:match('<a href="(.-)">') .. '\')">'
				end				
				end
				if left_str ~= '' then left_str = left_str .. '<center><img src="simpleTVImage:./luaScr/user/westSide/icons/left.png" height="120">'
				else left_str = '<center><img src="simpleTVImage:./luaScr/user/westSide/icons/left_no.png" height="120">' end
				if right_str ~= '' then right_str = right_str .. '<center><img src="simpleTVImage:./luaScr/user/westSide/icons/right.png" height="120">'
				else right_str = '<center><img src="simpleTVImage:./luaScr/user/westSide/icons/right_no.png" height="120">' end
				if not inAdr:match('episode%_') then
				poster_str = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. inAdr:gsub('season%_', '') .. 'season_' .. s .. '/episode_' .. e .. '/\')"><center><img src="' .. poster .. '" width = "960">'
				else
				poster_str = '<center><img src="' .. poster .. '" width = "960">'
				end
				data_out = ww:match('<div class="left%-box">(.-)</div>') or ''
				reiting_imdb = ww:match('Рейтинг IMDb: (.-)</div>') or ''
				if reiting_imdb ~= '' and not reiting_imdb:match('%-%-') then reiting_imdb = tonumber(reiting_imdb) reiting_imdb_str = '<img src="simpleTVImage:./luaScr/user/westSide/icons/menuIMDb.png" height="30" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/'
				.. reiting_imdb .. '.png" height="30" align="top">'  else reiting_imdb = '' reiting_imdb_str = '' end
				reiting_lf = ww:match('<div class="episode%-mark%-pane".->(.-)</div>') or ''
				if reiting_lf ~= '' then reiting_lf_str = '<img src="https://www.lostfilm.tv/favicon.ico" height="30" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/'
				.. reiting_lf .. '.png" height="30" align="top">' reiting_lf = tonumber(reiting_lf) else reiting_lf = '' reiting_lf_str = '' end
				infodesc = ww:match('<div class="body" style="height:20px;overflow:hidden">(.-)</div>') or ''
				a1[j] = {}
				a1[j].Id = j
				name = name:gsub('Длительность:.+', ''):gsub('%s+', ' ')
				a1[j].Name = trim(name)				
				a1[j].Adress = host .. 'v_search.php?c=' .. c .. '&s=' .. s .. '&e=' .. e .. '&lostfilm'				
--info				
				a1[j].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG02_1080p.jpg);"><table width="99\%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><h3><center>' .. titul_rezka_tor .. titul_hevc .. titul_yt .. titul_rezka .. titul_lostfilm .. 
				'</h3></td></tr><hr></table><table width="99%"><tr><td style="padding: 0px 10px 5px; vertical-align: middle;"><h3><b><center><font color=#00FA9A>' .. title1 .. '</font></b></h3></td></tr></table><table width="99%"><tr><td width="100" style="padding: 10px 10px 5px; vertical-align: middle;">'
				.. left_str .. '</td><td style="padding: 10px 10px 5px; vertical-align: middle;">' .. poster_str .. '</td><td width="100" style="padding: 10px 10px 5px; vertical-align: middle;">' .. right_str .. 
				'</td></tr></table><table width="99%"><tr><td style="padding: 0px 10px 5px; color: #CD7F32; vertical-align: middle;"><h5>' .. data_out .. '</h5></td><td style="padding: 0px 10px 5px; vertical-align: middle;">' .. reiting_imdb_str .. '<p>' .. reiting_lf_str .. 
				'</td></tr></table><table width="99%"><tr><td style="padding: 0px 10px 5px; color: #EEEEEE; vertical-align: middle;"><h5>' .. infodesc .. '</h5></td></tr></table></html>'
				a1[j].InfoPanelDesc = a1[j].InfoPanelDesc:gsub('"', "\"")
				a1[j].InfoPanelTitle = trim(name) .. ' | IMDb: ' .. reiting_imdb .. ', LFR: ' .. reiting_lf
				a1[j].InfoPanelName = title .. sesons_name
				a1[j].InfoPanelShowTime = 60000
				a1[j].InfoPanelLogo = poster
--end info				
				j = j + 1
			end
			if j == 1 then
				m_simpleTV.Http.Close(session)
				m_simpleTV.Control.CurrentAdress = 'https://s3.ap-south-1.amazonaws.com/ttv-videos/InVideo___This_is_where_ypprender_1554571391885.mp4'
				m_simpleTV.OSD.ShowMessageT({text = 'lostfilm ошибка[3]', color = ARGB(255, 255, 0, 0), showTime = 10000, id = 'channelName'})
			 return
			end

		a1 = table_reverse(a1)
		m_simpleTV.User.lostfilm.Tabletitle = a1
		for i = 1, #a1 do
			a1[i].Id = i
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOptions then
			a1.ExtButton0 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOptions, ButtonScript = 'GetMovieQuality()'}
		else
			a1.ExtButton0 = {ButtonEnable = true, ButtonName = '⚙', ButtonScript = 'GetMovieQuality()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			a1.OkButton = {ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			a1.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		else
			a1.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		end		
		a1.ExtParams = {FilterType = 2}
		if j == 2 then
			a1[1].Name = title
			m_simpleTV.OSD.ShowSelect_UTF8('lostfilm', 0, a1, 5000, 2 + 64 + 32)
			retAdr = a1[1].Adress
			title = a1[1].Name
		end
		if j > 2 then
			local _, id = m_simpleTV.OSD.ShowSelect_UTF8(title .. sesons_name, 0, a1, 10000, 2)
			if not id then
				id = 1
			end
			retAdr = a1[id].Adress
			title = title .. ' - ' .. m_simpleTV.User.lostfilm.Tabletitle[1].Name			
		end
		m_simpleTV.Control.ExecuteAction(108,1)
		elseif retAdr:match('lostfilm%.tv%/new') then
		local title = 'lostfilm'
		local url1 = 'https://www.lostfilm.tv'
		m_simpleTV.Interface.SetBackground({BackColor = 0, BackColorEnd = 255, PictFileName = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg', TypeBackColor = 0, UseLogo = 3, Once = 1})
		local rc, answer = m_simpleTV.Http.Request(session, {url = retAdr})
			if rc ~= 200 then
				m_simpleTV.Http.Close(session)
				m_simpleTV.OSD.ShowMessageT({text = 'lostfilm ошибка[1]-' .. rc, color = ARGB(255, 255, 0, 0), showTime = 5000, id = 'channelName'})
			 return
			end
		local retAdr = background_chanel
		local t, i, k, ser_new_str = {}, 1, 1, '<table width="99%"><tr>'
		local name, ser_name, ser, adr, logo
		answer:gsub('\n', ' ')
		for w in answer:gmatch('<div class="row">(.-)markEpisodeAsWatched') do
				name = w:match('<div class="name%-ru">(.-)</div>')
				name = name:gsub(',', ' '):gsub('%s%s+', ' ')
				name_eng = w:match('<div class="name%-en">(.-)</div>')
				name_eng = name_eng:gsub(',', ' '):gsub('%s%s+', ' ')
				ser_name = w:match('<div class="alpha">(.-)</div>') or ''
				ser_name_eng = w:match('<div class="beta">(.-)</div>') or ''
				ser = w:match('<div class="left%-part">(.-)</div>') or ''
				adr = w:match('href="(.-)"') or ''
				da = w:match('<div class="right%-part">(.-)</div>') or ''
				rtg = w:match('Lostfilm%.TV">(.-)</div>') or ''
				logo = w:match('<img src="(.-)"') or ''
					if not name or not adr or not ser_name or not ser then break end
				icon = logo:gsub('image', 'icon'):gsub('^//', 'https://')
				adr_all = url1 .. adr:gsub('season.-$', '')
				t[i] = {}
				t[i].logo = logo:gsub('^//', 'https://')
				t[i].name = name:gsub(',', ' '):gsub('%s%s+', ' ')
				t[i].address = url1 .. adr
				t[i].video_title = da .. ' | ' .. ser .. ' "' .. ser_name .. '" | LFR: ' .. rtg
				t[i].video_desc = '<td style="padding: 10px 10px 5px; color: #EBEBEB; vertical-align: middle;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\''.. t[i].address .. '\')"><img src="' .. t[i].logo ..
				'" width = "447"></a><h5><center>' .. ser .. ' <font color=#CD7F32>' .. da .. '</font></h5><h4><font color=#00FA9A>' .. t[i].name ..
				'</font> <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adr_all .. '\')"><img style="float:right;" src="' .. icon .. 
				'" height="54"></a></h4><h5><font color=#BBBBBB>' .. name_eng .. '</font></h5><h5>' .. ser_name .. '</h5><h5><font color=#BBBBBB>' .. ser_name_eng ..
				'</font></h5><h5><img src="https://www.lostfilm.tv/favicon.ico" height="30" align="top"><img src="simpleTVImage:./luaScr/user/westSide/stars/' .. rtg .. 
				'.png" height="30" align="top"></h5></td>'				
				t[i].video_desc = t[i].video_desc:gsub('"', '\"')
				t[i].video_title = t[i].video_title:gsub('"', '\"')
				if k == 4 then ser_new_str = ser_new_str .. '</tr><tr>' k = 1 end
				ser_new_str = ser_new_str .. t[i].video_desc
				i = i + 1
				k = k + 1
			end
			------------------
	local page_str = ''
	answer_page = answer:match('<div class="pagging%-pane">(.-)<div class="text%-block serials%-list">')
	if answer_page then
	active = answer_page:match('class="item active">(.-)</a>')
	answer_page = answer_page:gsub('Предыдущая страница', ' « '):gsub('Следующая страница', ' » '):gsub('<a class="noitem">%.%.%.</a>', ' ... '):gsub('<div.->', ''):gsub(' class="item active"', ''):gsub(' class="item"', ''):gsub('</div>', '')
	answer_page = answer_page:gsub('<a href="', ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress%(\'' .. url1):gsub('">', '\'\)" style="color: #BBBBBB; text-decoration: none;"> ')
	page_str = '<font color=#EBEBEB>Серфинг по страницам</font> (стр. ' .. active .. '): ' .. answer_page
	page_str = '<table width="99%"><tr><td colspan="3" style="color: #CD7F32;"><center><h3>' .. page_str .. '</h3></td></tr></table>'
	else page_str = ''
	end
------------------
	local tab = {}
	tab[1] = {}
	tab[1].Id = 1
	tab[1].Name = title
	tab[1].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_1080p.png);"><table width="99%"><tr><td colspan="3" style="padding: 10px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h3><center>' ..
	titul_rezka_tor .. titul_hevc .. ' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3></td></tr><hr></table>' ..
	page_str .. '<table width="99%">' .. ser_new_str .. '</tr></table></html><html>' .. page_str .. '</html>'
	tab[1].InfoPanelDesc = tab[1].InfoPanelDesc:gsub('"', "\"")
	tab[1].InfoPanelTitle = title
	tab[1].InfoPanelName = title
	tab[1].InfoPanelShowTime = 60000
	tab[1].InfoPanelLogo = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg'
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		end
	m_simpleTV.OSD.ShowSelect_UTF8('LostFilm', 0, tab, 8000, 32 + 64 + 128)
	m_simpleTV.Control.SetTitle(title)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(tab[1].InfoPanelLogo, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.Control.CurrentAddress = retAdr
	m_simpleTV.Control.ExecuteAction(108,0)
	m_simpleTV.Control.ExecuteAction(108,1)		
	end
	if not retAdr:match('lostfilm%.tv%/new') then
	local Posterc = retAdr:match('c=(%d+)')
	local Posters = retAdr:match('s=(%d+)')
	Posters = 'shmoster_s' .. Posters
	if Posters == 'shmoster_s999' then
		Posters = 'poster'
	end
	if Posterc and Posters then
		m_simpleTV.User.lostfilm.posterUrl = 'http://static.lostfilm.tv/Images/' .. Posterc .. '/Posters/' .. Posters .. '.jpg'
		m_simpleTV.Interface.SetBackground({BackColor = 0, BackColorEnd = 255, PictFileName = m_simpleTV.User.lostfilm.posterUrl, TypeBackColor = 0, UseLogo = 3, Once = 1})
	end
	m_simpleTV.Control.ChangeChannelLogo(m_simpleTV.User.lostfilm.posterUrl or 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg', m_simpleTV.Control.ChannelID)
	m_simpleTV.Http.SetCookies(session, retAdr, '', m_simpleTV.User.lostfilm.cooki)
	rc, answer = m_simpleTV.Http.Request(session, {url = retAdr})
		if rc ~= 200 then
			m_simpleTV.Http.Close(session)
			m_simpleTV.OSD.ShowMessageT({text = 'lostfilm ошибка[4.1]-' .. rc, color = ARGB(255, 255, 0, 0), showTime = 5000, id = 'channelName'})
		 return
		end
	local url = answer:match('location%.replace%("(.-)"')
		if not url then
			m_simpleTV.Control.ExecuteAction(37)
			m_simpleTV.Http.Close(session)
			m_simpleTV.Control.CurrentAdress = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg$OPT:image-duration=10'
			m_simpleTV.OSD.ShowMessageT({text = 'в браузере удалите куки lostfilm, перелогинтесь\n\nlostfilm ошибка[6]', color = ARGB(255, 255, 0, 0), showTime = 1000 * 10, id = 'channelName'})
		 return
		end
	m_simpleTV.Http.SetCookies(session, retAdr, '', m_simpleTV.User.lostfilm.cooki)
	rc, answer = m_simpleTV.Http.Request(session, {url = url})
		if rc ~= 200 then
			m_simpleTV.Control.ExecuteAction(37)
			m_simpleTV.Http.Close(session)
			m_simpleTV.Control.CurrentAdress = 'https://www.tarablog.net.ua/wp-content/uploads/2014/01/lostfilm1.jpg$OPT:image-duration=10'
			m_simpleTV.OSD.ShowMessageT({text = 'неправильный логин/пароль\nили в браузере удалите куки lostfilm, перелогинтесь\n\nlostfilm ошибка[7]', color = ARGB(255, 255, 0, 0), showTime = 1000 * 10, id = 'channelName'})
		 return
		end
	retAdr = GetLostfilmAddress(answer)
		if not retAdr then
			m_simpleTV.Http.Close(session)
			m_simpleTV.Control.CurrentAdress = background_chanel
		 return
		end
		if retAdr:match('hash_error') then retAdr = background_chanel end
		if prx ~= '' then
			local rc, torFile = m_simpleTV.Http.Request(session, {url = retAdr:gsub('torrent://', ''), writeinfile = true})
			m_simpleTV.Http.Close(session)
				if rc ~= 200 then return end
			m_simpleTV.Control.CurrentAddress = 'torrent://' .. torFile
		 return
		end
	m_simpleTV.Http.Close(session)
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = ARGB(255, 155, 155, 255), showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.Control.CurrentAdress = retAdr
	end
-- debug_in_file(retAdr .. '\n')
-- видеоскрипт для сайта http://onhdrezka-download.com (11/09/20) v.2.1
-- необходим: Acestream
-- открывает подобные ссылки:
-- http://onhdrezka-download.com/p/866-vnutri-igry-2019-hdrezka-studio
		if m_simpleTV.Control.ChangeAddress ~= 'No' then return end
	local inAdr = m_simpleTV.Control.CurrentAddress
		if not inAdr then return end
		if not inAdr:match('^https?://rezka%.cc') then return end
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 1000, id = 'channelName'})
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = '', TypeBackColor = 0, UseLogo = 0, Once = 1})
	end
	local function showError(str)
		m_simpleTV.OSD.ShowMessageT({text = 'hdrezka-download ошибка: ' .. str, showTime = 5000, color = 0xffff1000, id = 'channelName'})
	end
	m_simpleTV.Control.ChangeAddress = 'Yes'
	m_simpleTV.Control.CurrentAddress = ''
	local titul_rezka = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag\')"><img src="https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png" height="54" align="top"></a>'
	local titul_hevc = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/h265.png" height="54" align="top"></a>'
	local titul_rezka_tor = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="https://rezka.cc/apple-touch-icon.png" height="54" align="top"></a>'
	local titul_yt = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.youtube.com/feed/channels\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="54" align="top"></a>'
	local titul_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/new\/\')"><img src="https://www.lostfilm.tv/favicon.ico" height="54" align="top"></a>'
	local search_home = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/home.jpg" width = "330"></a>'
	local search_movies = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc/films\')"><center><img src="simpleTVImage:./luaScr/user/westSide/icons/movies.jpg" width = "330"></a>'
	local search_tvshows = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc/series\')"><center><img src="simpleTVImage:./luaScr/user/westSide/icons/tvshows.jpg" width = "330"></a>'
	local search_anime = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc/animation\')"><center><img src="simpleTVImage:./luaScr/user/westSide/icons/anime.jpg" width = "330"></a>'
	local search_kids = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc/cartoons\')"><center><img src="simpleTVImage:./luaScr/user/westSide/icons/kids.jpg" width = "330"></a>'
	local start_search = '<tr><td style="padding: 5px 10px 0px;">' .. search_movies .. '</td>' ..
	'<td style="padding: 5px 10px 0px;">' .. search_tvshows .. '</td>' ..
	'<td style="padding: 5px 10px 0px;">' .. search_anime .. '</td>' ..
	'<td style="padding: 5px 10px 0px;">' .. search_kids .. '</td></tr></table>'
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
	local session = m_simpleTV.Http.New('Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.3729.121 Safari/537.36')
		if not session then
			showError('1')
		 return
		end
	m_simpleTV.Http.SetTimeout(session, 8000)
	local host = inAdr:match('(https?://.-)/')
	local background_chanel = 'https://radio-stream-1.obozrevatel.com/radiorelaxfm128.mp3'
	local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr})
		if rc ~= 200 then
			showError('2')
			m_simpleTV.Http.Close(session)
		 return
		end
	answer = answer:gsub('\n\n', ' '):gsub('\n', ' '):gsub('  ', '')
	local title = answer:match('"si%-title">(.-)<') or answer:match('<h1 class="h1__">(.-)</h1>') or 'HDRezka'
	rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. title .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="54" align="top"></a>'
	local cover = answer:match('<img src="([^"]+%.png)') or answer:match('<img src="([^"]+%.jpg)')
	cover_str = answer:match('<div class="si%-cover">(.-)</div>')
	if cover_str then cover_str = cover_str:gsub('%">', '\')">'):gsub('%/>', 'height="480">'):gsub('href=%"', 'href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. host) end
	answer_info = answer:match('<div class="fullstory%-wrapper">.-<div class="download%-wrapper">')
	if answer_info then
	desc1 = answer_info:match('(<h1 class="si%-title">.-)<div class="si%-story">') or answer_info:match('(<h1 class="si%-title">.-)<div class="download%-wrapper">')
	if desc1 then
	desc1 = desc1:gsub('\n', ' '):gsub('</li><li>', ', '):gsub('<ul>', ''):gsub('</ul>', ''):gsub('<li>', '<h5>'):gsub('</li>', '</h5>'):gsub('<h1 class="si%-title">', '<h4><center><font color=#00FA9A>'):gsub('</h1>', rezka_poisk .. '</font></h4>'):gsub('<div class="si%-param__date">', ''):gsub('<div class="si%-param">', '<h4>'):gsub('<div class="si%-date">', '<h4>'):gsub('<div class="si%-data">', ''):gsub('</div>', '</h4>')
	desc1 = desc1:gsub('</h4></h4>', ''):gsub('>   <', '><'):gsub('>  <', '><'):gsub('> <', '><')
	s, e = desc1:match('S(%d+)E(%d+)')
	if s and e then ses = tonumber(s) .. ' сезон ' .. tonumber(e) .. ' серия' else ses = '' end
	desc1 = desc1:gsub('S(%d+)E(%d+)', ses)
	if desc1:match('мультфильм') then isvideo = 'мультфильм'
	elseif desc1:match('фильм') then isvideo = 'фильм'
	elseif desc1:match('сериал') then isvideo = 'сериал'
	elseif desc1:match('аниме') then isvideo = 'аниме'
	else isvideo = ''
	end
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="simpleTVImage:./luaScr/user/westSide/country/' .. country_ID .. '.png" height="54" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if desc1:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Южная Корея') or desc1:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if desc1:match('США') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
	desc1 = desc1 .. '<p>' .. country_ID
-------------
	end
	desc2 = answer_info:match('<div class="si%-story">(.-)</div>') or ''
	if desc2 ~= '' then
	desc2 = '<table width="99%"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>' .. desc2 .. '</h5></td></tr></table>'
	end
	end
	if cover then
		cover = cover:gsub('^/', host .. '/')
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = cover, TypeBackColor = 0, UseLogo = 3, Once = 1})
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
	end
--------------
	if not m_simpleTV.User then
		m_simpleTV.User = {}
	end
	if not m_simpleTV.User.HDRezka then
		m_simpleTV.User.HDRezka = {}
	end
	m_simpleTV.User.HDRezka.DelayedAddress = nil
	function OnMultiAddressOk_HDRezka(Object, id)
		if id == 0 then
			OnMultiAddressCancel_HDRezka(Object)
		else
			m_simpleTV.User.HDRezka.DelayedAddress = nil
		end
	end
	function OnMultiAddressCancel_HDRezka(Object)
		if m_simpleTV.User.HDRezka.DelayedAddress then
			local state = m_simpleTV.Control.GetState()
			if state == 0 then
				m_simpleTV.Control.SetNewAddress(m_simpleTV.User.HDRezka.DelayedAddress)
			end
			m_simpleTV.User.HDRezka.DelayedAddress = nil
		end
		m_simpleTV.Control.ExecuteAction(36, 0)
	end
	answer_item = answer:match('<div class="download%-wrapper">.-<script>')
	if answer_item then
	local adr, name
	local t, i, name1 = {}, 1, ''
		for w in answer_item:gmatch('<a.-</a>') do
		if w:match('%/sd%/') or w:match('%/hd%/') or w:match('%/fhd%/') or w:match('%/p%/') then
			name = w:match('>(.-)</a>'):gsub('1080p', 'FHD'):gsub('720p', 'HD')
			adr = w:match('href="(.-)"')
			s, e = adr:match('%-(%d)%-sezon%-(.-)%-seriya')
			s_all = adr:match('%-(%d)%-sezon%-polnostyu%-')
			if s and e then
			name1 = ' ' .. s .. ' сезон ' .. e .. ' серия'
			end
			if s_all then
			name1 = ' ' .. s_all .. ' сезон'
			end
			if not adr or not name then break end
			t[i] = {}
			t[i].Name = name .. name1
			t[i].Address = host .. adr
			t[i].res = name
			i = i + 1
		end
		end
		if i == 1 then
			showError('4')
		 return
		end
	t = table_reverse(t)
	table.sort(t, function(a, b) return a.Name < b.Name end)
	for i = 1, #t do
		t[i].Id = i
	end
	if i > 2 then
		local _, id = m_simpleTV.OSD.ShowSelect_UTF8(title, 0, t, 5000, 1)
		id = id or 1
		inAdr = t[id].Address
		res = t[id].res
		name = t[id].Name
	else
		inAdr = t[1].Address
		res = t[1].res
		name = t[1].Name
	end
	ishd = res:gsub('FHD', 'videofhd'):gsub('HD', 'videohd'):gsub('SD', 'videosd')
	ishd = '<a href="simpleTVLua:m_simpleTV.Control.ExecuteAction(37) m_simpleTV.Control.ExecuteAction(63)"><img src="simpleTVImage:./luaScr/user/westSide/resolution/' .. ishd .. '.png" height="54" align="top"></a>'
	local retAdr
	if inAdr:match('%/sd%/') or inAdr:match('%/hd%/') or inAdr:match('%/fhd%/') then
	rc, answer = m_simpleTV.Http.Request(session, {url = inAdr, writeinfile = true})
	m_simpleTV.Http.Close(session)
		if rc ~= 200 then
			showError('5')
		 return
		end
	retAdr = 'torrent://' .. answer
	else m_simpleTV.Control.PlayAddress(inAdr)
	end
	if inAdr:match('%-polnostyu%-') then
	e1, e2 = inAdr:match('%-polnostyu%-(%d)%-(.-)%-serii')
	e = tonumber(e2) - e1 + 1
	local tab = {}	
	for i = 1, e do
	tab[i] = {}
	tab[i].Id = i
	tab[i].Address = retAdr .. '$TORRENTINDEX=' .. i - 1
	retAdr:match('S(%d+)E(%d+)')
	tab[i].Name = i - e1 + 1 .. ' серия'
	tab[i].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG02_1080p.jpg);"><table width="99%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;">' .. cover_str ..
	'</td><td style="padding: 10px 5px 0px; color: #BBBBBB; vertical-align: middle;"><h5>' .. titul_rezka_tor .. titul_hevc .. titul_yt .. titul_rezka .. titul_lostfilm .. ishd .. '</h5>' .. desc1 .. '</td></tr></table>' .. desc2 .. '</html>'
	tab[i].InfoPanelDesc = tab[i].InfoPanelDesc:gsub('"', "\"")
	tab[i].InfoPanelTitle = name .. ' ' .. tab[i].Name
	tab[i].InfoPanelName = title
	tab[i].InfoPanelShowTime = 60000
	tab[i].InfoPanelLogo = cover
	i = i + 1
	end
	m_simpleTV.User.HDRezka.titleTab = tab
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_HDRezka()'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_HDRezka()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOptions then
			tab.ExtButton0 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOptions, ButtonScript = 'm_simpleTV.Control.ExecuteAction(63)'}
		else
			tab.ExtButton0 = {ButtonEnable = true, ButtonName = '⚙', ButtonScript = 'm_simpleTV.Control.ExecuteAction(63)'}
		end		
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.OSD.ShowSelect_UTF8(title .. ' ' .. name, 0, tab, 8000, 2 + 64)
	m_simpleTV.Control.CurrentAddress = tab[1].Address
	m_simpleTV.Control.SetTitle(title)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	else	
	local tab = {}
	tab[1] = {}
	tab[1].Id = 1
	tab[1].Name = title
	tab[1].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG02_1080p.jpg);"><table width="99%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;">' .. cover_str ..
	'</td><td style="padding: 10px 5px 0px; color: #BBBBBB; vertical-align: middle;"><h5>' .. titul_rezka_tor .. titul_hevc .. titul_yt .. titul_rezka .. titul_lostfilm .. ishd .. '</h5>' .. desc1 .. '</td></tr></table>' .. desc2 .. '</html>'
	tab[1].InfoPanelDesc = tab[1].InfoPanelDesc:gsub('"', "\"")
	tab[1].InfoPanelTitle = name
	tab[1].InfoPanelName = title
	tab[1].InfoPanelShowTime = 60000
	tab[1].InfoPanelLogo = cover
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_HDRezka()'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_HDRezka()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOptions then
			tab.ExtButton0 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOptions, ButtonScript = 'm_simpleTV.Control.ExecuteAction(63)'}
		else
			tab.ExtButton0 = {ButtonEnable = true, ButtonName = '⚙', ButtonScript = 'm_simpleTV.Control.ExecuteAction(63)'}
		end
	m_simpleTV.OSD.ShowSelect_UTF8('HD-Rezka', 0, tab, 8000, 32 + 64 + 128)
	m_simpleTV.Control.SetTitle(title)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.Control.CurrentAddress = retAdr
	end
	end
--------------блок стены лого
		local answer_stena = answer:match('<div class="cardlist cardlist%-cats">.-<script>') or answer:match('<div class="cardlist">.-<script>')
--		local title = answer:match('<h1 class="h1__">(.-)</h1>')
		title = title:gsub('Скачать ', '')
		if answer_stena then
			local is, ks = 1, 1
			local name_s, adr_s, logo_s, info_s, desc_s = '','','','',''
			for w in answer_stena:gmatch('<a (href=".-</a>)') do
				name_s = w:match('title="(.-)"'):gsub('&quot;', '"')
				adr_s = w:match('href="(.-)"')
				logo_s = w:match('<img src="(.-)"') or ''
				info_s = w:match('param">(.-)<') or ''
				year_s = info_s:match('(.-),') or info_s
				country_s = info_s:match(', (.-),') or ''
				genre_s = info_s:match(',.-,(.-)$') or ''
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="simpleTVImage:./luaScr/user/westSide/country/' .. country_ID .. '.png" height="36" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if country_s:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Южная Корея') or country_s:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country_s:match('США') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
-------------
				if ks == 5 then desc_s = desc_s .. '</tr><tr>' ks = 1 end
				desc_s = desc_s .. '<td style="padding: 5px 10px 5px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. host .. adr_s ..
				'\')"><center><img src="' .. logo_s .. '" height = "495" width = "330"></a><center><h5><font color=#00FA9A>' .. name_s ..
				'</font></h5><h5><font color=#CD7F32>' .. year_s .. '</font> ' .. country_ID .. genre_s .. '</h5></td>'
				ks = ks + 1
		end
------------------
	local page_str = ''
	answer_page = answer:match('<div class="navigation">(.-)</div>')
	if answer_page then
	answer_page = answer_page:gsub('&amp;', '&')
	answer_page = m_simpleTV.Common.multiByteToUTF8(answer_page)
	answer_page = answer_page:gsub('&laquo;', ' « '):gsub('&raquo;', ' » '):gsub('<span class="btn active">', ' '):gsub('</span>', ' '):gsub('<a class="btn disabled">%.%.%.</a>', ' ... ')
	answer_page = answer_page:gsub('<a class="btn" href="', ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress%(\'' .. host):gsub('">', '\'\)" style="color: #BBBBBB; text-decoration: none;"> ')
	page_str = '<font color=#EBEBEB>Серфинг по страницам: </font>' .. answer_page
	page_str = '<table width="99%"><tr><td style="color: #CD7F32;"><center><h3>' .. page_str .. '</h3></td></tr></table>'
	else page_str = ''
	end
------------------
	if desc_s and desc_s ~= '' then desc_s = '<table width="99%"><tr>' .. desc_s .. '</tr></table>' else desc_s = '' end
	local retAdr = background_chanel
	local tab = {}
	tab[1] = {}
	tab[1].Id = 1
	tab[1].Name = title
	tab[1].InfoPanelDesc = '<html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_1080p.png);"><table width="99%%"><tr><td colspan="4"><h3><center>' ..
	titul_rezka_tor .. titul_hevc .. ' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3></td></tr>' .. start_search ..
	'</html><html><body bgcolor="#434750" style="background-image: url(simpleTVImage:./luaScr/user/westSide/icons/BG01_1080p.png);">' .. page_str .. desc_s .. page_str .. '</html>'
	tab[1].InfoPanelDesc = tab[1].InfoPanelDesc:gsub('"', "\"")
	tab[1].InfoPanelTitle = title
	tab[1].InfoPanelName = title
	tab[1].InfoPanelShowTime = 60000
	tab[1].InfoPanelLogo = cover
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 45, ButtonImageCy= 45, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_HDRezka()'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_HDRezka()'}
		end
	m_simpleTV.OSD.ShowSelect_UTF8('HD-Rezka', 0, tab, 8000, 32 + 64 + 128)
	m_simpleTV.Control.SetTitle(title)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.Control.CurrentAddress = retAdr
	m_simpleTV.Control.ExecuteAction(108,0)
	m_simpleTV.Control.ExecuteAction(108,1)
--------------конец блока стены лого
	end
-- debug_in_file(retAdr .. '\n')
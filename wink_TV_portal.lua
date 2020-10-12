-- видеоскрипт для поиска в видеобазе Wink
	if m_simpleTV.Control.ChangeAddress ~= 'No' then return end
	if not m_simpleTV.Control.CurrentAddress:match('^https://wink%.rt%.ru/tv$')
		and not m_simpleTV.Control.CurrentAddress:match('^https://wink%.rt%.ru/tv.+') then
		return
	end
	local inAdr = m_simpleTV.Control.CurrentAddress
--	if inAdr == 'https://wink.rt.ru/tv' then inAdr = 'https://wink.rt.ru/tv/580' end
	m_simpleTV.Control.ChangeAddress = 'Yes'
	m_simpleTV.Control.CurrentAddress = ''
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 1000, id = 'channelName'})
--	local logo = 'https://wink.rt.ru/apple-touch-icon.png'
		local masshtab = m_simpleTV.User.paramScriptForSkin_masshtab or 1
		if m_simpleTV.User.paramScriptForSkin_background_chanel then
			background_chanel = m_simpleTV.User.paramScriptForSkin_background_chanel
		else
			background_chanel = 'https://radio-stream-1.obozrevatel.com/radiorelaxfm128.mp3'
		end
		background_chanel = 'https://zabava-htlive.cdn.ngenix.net/hls/CH_VSETVHD/variant.m3u8'
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
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
	if Weather and Weather.Param.enabled==1 then
		local pogoda = Weather.api.GetCurTemp()
		if type(pogoda)=="table" then
			m_simpleTV.OSD.ShowMessage_UTF8( pogoda.cur_temp .. pogoda.letter .. '\n' .. pogoda.cur_icon)
			pogoda_cur_temp = pogoda.cur_temp
			pogoda_letter = pogoda.letter
			pogoda_cur_icon = pogoda.cur_icon
			pogoda_str = '<td width="' .. 160*masshtab .. '" style="padding: 10px 10px 5px; vertical-align: middle; color: #EBEBEB;"><h3><img src="' .. pogoda_cur_icon .. '" height="' .. 36*masshtab .. '" align="top">' ..	pogoda_cur_temp .. pogoda_letter .. '</h3></td>'
		else m_simpleTV.OSD.ShowMessage_UTF8("NULL")
			pogoda_str = ''
		end
	else m_simpleTV.OSD.ShowMessage_UTF8("дополнение ПОГОДА не установлено")
			pogoda_str = ''
	end
	portal_str = '<table width="99\%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><h3><center>' ..
	titul_rezka_tor .. titul_hevc .. titul_lostfilm ..' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_wink ..
	'</h3></td>' .. pogoda_str .. '</tr></table><hr>'
	if not inAdr:match('&kinopoisk') then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = 0, TypeBackColor = 0, UseLogo = 0, Once = 1})
	end
	if not m_simpleTV.User.Wink then
		m_simpleTV.User.Wink = {}
	end

	local userAgent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.3809.87 Safari/537.36'
	local session = m_simpleTV.Http.New(userAgent)
		if not session then return end
	m_simpleTV.Http.SetTimeout(session, 12000)
	inAdr = m_simpleTV.Common.multiByteToUTF8(inAdr)
--	retAdr = m_simpleTV.Control.CurrentAddress
	function OnMultiAddressOk_Wink(Object, id)
		if id == 0 then
			OnMultiAddressCancel_Wink(Object)
		end
	end
	function OnMultiAddressCancel_Wink(Object)
		m_simpleTV.Control.ExecuteAction(36, 0)
	end
	if m_simpleTV.Control.MainMode == 0 then
--		m_simpleTV.Control.ChangeChannelLogo(logo, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
--		m_simpleTV.Control.ChangeChannelName('Wink TV', m_simpleTV.Control.ChannelID, false)
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = './luaScr/user/westSide/icons/Channels.jpg', TypeBackColor = 0, UseLogo = 1, Once = 1})
	end
	local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr:gsub('?start_time=.-$', '')})
--	m_simpleTV.Http.Close(session)
		if rc ~= 200 then return end
----------------logo background		
--[[	timeplus = inAdr:match('start_time=(%d)$')
	if timeplus then
	for answer_data1 in answer:gmatch('<label for=".-</label>') do
	if answer_data1:match('checked') then
	timein_data1 = answer_data1:match('value="(%d+)"')
	end
	end
	data_stroka = timeplus - timein_data1
	data_stroka_min = data_stroka/60
	data_stroka_hor = math.floor(data_stroka_min/60)
	data_stroka_min = data_stroka_min - (data_stroka_hor*60)
	data_stroka = data_stroka_hor .. ':' .. data_stroka_min
	for answer_epg1 in answer:gmatch('<div class="root_r1ru04lg time_t1krzpy3.-root_subtitle2_r18emsye">.-</p>') do
	sitedata_stroka = answer_epg1:match('<div class="root_r1ru04lg time_t1krzpy3.-root_subtitle2_r18emsye">(.-)</div>')
	m_simpleTV.OSD.ShowMessageT({text = data_stroka .. ' | ' .. sitedata_stroka, showTime = 1000 * 50})
	if sitedata_stroka == data_stroka then
	background1 = answer_epg1:match('src="(.-)"')
	background1 = background1:gsub('176x132', '704x528')
	end
	end
	end --]]
	background = answer:match('background:url%((.-)%)">') or poster1 or './luaScr/user/westSide/icons/Channels.jpg'
-------------------- 
	m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = background, TypeBackColor = 0, UseLogo = 3, Once = 1})

	title = answer:match('property="og:title" content="(.-)"')
	answer_group = answer:match('<div class="scroll_s8pomy7">(.-)</div></form>')
	
	local tg, j, kg, desc_g = {}, 1, 1, ''
	for ww in answer_group:gmatch('(<label for=.-)</label>') do
	if not ww:match('Все')
	and not ww:match('Взрослые')
	and not ww:match('Кулинарные')
	and not ww:match('Региональные')
	and not ww:match('Телемагазины')
	and not ww:match('Здоровье')
	then
	tg[j] = {}
	tg[j].name = ww:match('<span.->(.-)</span>') or 'Wink'
	tg[j].logo = 'simpleTVImage:./luaScr/user/westSide/genres_tv/' .. tg[j].name .. '.png'
	tg[j].adr = ww:match('<label for="(.-)"')
	if tg[j].name and tg[j].adr
	then
	tg[j].adr = 'https://wink.rt.ru/tv?theme=' .. tg[j].adr
	if tg[j].name == 'Все' then tg[j].adr = 'https://wink.rt.ru/tv' end
			if kg == 5 then
				desc_g = desc_g .. '</tr><tr>' kg = 1
			end
				if tg[j].adr == inAdr then
				desc_g = desc_g .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. tg[j].adr ..
				'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. tg[j].logo .. '" height = "' .. 82*masshtab .. '" width = "' .. 208*masshtab ..
				'"><h4><center><font color=#ED4830>' .. tg[j].name .. ' </font></h4></a></td>'
				else
				desc_g = desc_g .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. tg[j].adr ..
				'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. tg[j].logo .. '" height = "' .. 82*masshtab .. '" width = "' .. 208*masshtab ..
				'"><h4><center><font color=#EBEBEB>' .. tg[j].name .. ' </font></h4></a></td>'
				end
		j = j + 1
		kg = kg + 1
	end
	end
	end
	local answer_wink = answer:match('<div class="root_r1on6mqn" data%-test="channels%-list">.-<div class="loader_l161cauy">')
	if answer_wink and not answer:match('<div data%-test="channel%-content" class="root_rf3liu8 content_c1etjow5">') then
	local logo = './luaScr/user/westSide/icons/Channels.jpg'
	local t, i, k, desc = {}, 1, 1, '<table width="99%%"><tr>'
	for w in answer_wink:gmatch('<a style=".-</a>') do
	t[i] = {}
	t[i].name = w:match('"/><img alt="(.-)"')
	t[i].info = w:match('<div class="title_t15asdfr">(.-)</div>') or ''
	t[i].time_in = w:match('<span class="time_ttaxu1w">(.-)</span>') or ''
	t[i].time_info = w:match('"%-%-timeline%-value:(.-)%%">') or 0
	t[i].age = w:match('<span class="age_a12708nt">(.-)</span>') or ''
	t[i].poster = w:match('"/><img.-src="(.-)"')
	t[i].adress = w:match('href="(.-)"')
	t[i].adress = 'https://wink.rt.ru' .. t[i].adress
	if t[i].name and t[i].adress
	then
			if k == 5 then
				desc = desc .. '</tr><tr>' k = 1
			end
				desc = desc .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t[i].adress ..
				'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. t[i].poster .. '" height = "' .. 120*masshtab .. '" width = "' .. 208*masshtab ..
				'"><h4><font color=#CD7F32><center>' .. t[i].time_in  .. '</font><img src="simpleTVImage:./luaScr/user/westSide/progress/p' .. t[i].time_info .. '.png" height="' .. 36*masshtab .. '" align="top"></h4><h5><center><font color=#EBEBEB>' .. t[i].info .. ' </font><font color=#CD7F32>' .. t[i].age .. '</font></h5></a></td>'
		i = i + 1
		k = k + 1
	end
	end
			t[1] = {}
					t[1].Id = 1
					t[1].Name = title
					t[1].Address = background_chanel
					t[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. '<table width="99\%"><tr>' .. desc_g .. '</tr></table>' ..	desc .. '</tr></table></html>'
					t[1].InfoPanelDesc = t[1].InfoPanelDesc:gsub('"', '\"')
					t[1].InfoPanelName = t[1].Name
					t[1].InfoPanelTitle = title
					t[1].InfoPanelShowTime = 30000
					t[1].InfoPanelLogo = './luaScr/user/westSide/icons/Channels.jpg'
			m_simpleTV.User.Wink.Tab = t
					m_simpleTV.OSD.ShowSelect_UTF8('Wink', 0, t, 8000, 32 + 64 + 128)
			if not t then
			m_simpleTV.OSD.ShowMessageT({text = 'Wink', showTime = 1000 * 5, id = 'channelName'})
			end
		m_simpleTV.Control.CurrentAddress = background_chanel
		inAdr = background_chanel
		t.ExtButton1 = {ButtonEnable = true, ButtonName = '❌', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		t.ExtParams = {}
		t.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_Wink'
		t.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_Wink'
		m_simpleTV.Control.SetTitle(title)
		m_simpleTV.Control.CurrentTitle_UTF8 = title
--		m_simpleTV.OSD.ShowMessageT({text = title, showTime = 1000 * 5, id = 'channelName'})
		if inAdr == background_chanel then
		m_simpleTV.Control.ExecuteAction(108,0)
		m_simpleTV.Control.ExecuteAction(108,1) end
elseif answer:match('<div data%-test="channel%-content" class="root_rf3liu8 content_c1etjow5">')
then
local title = answer:match('<h1 class="root_r1ru04lg title_t1kbub20 root_header1_r1swja1w" data%-test="media%-item%-name">(.-)<')
 logo = answer:match('<div class="poster_pbugp4u.-src="(.-)"')
local te, ie, ke, desc_e = {}, 1, 1, ''
local p_shift, t_shift, lable_notarchiv = '', '', ''
for answer_epg in answer:gmatch('<div class="root_r1ru04lg time_t1krzpy3.-root_subtitle2_r18emsye">.-</p>') do
	te[ie] = {}
	if answer_epg:match('time_live_')
	then
	te[ie].isarchiv = '0'
	te[ie].islive = '1'
	else
	te[ie].isarchiv = ''
	te[ie].islive = ''
	end
	lable_notarchiv = lable_notarchiv .. te[ie].isarchiv
	te[ie].name = answer_epg:match('<h3 class="root_r1ru04lg name_n12g9e81 root_subtitle2_r18emsye">(.-)</h3>')
	rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. te[ie].name .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
	yt_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'-' .. te[ie].name .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
	te[ie].name_str = te[ie].name .. rezka_poisk .. yt_poisk
	te[ie].info = answer_epg:match('<p class="root_r1ru04lg description_d1o07pj4 root_body1_rt60wi">(.-)</p>') or ''
	te[ie].time_in = answer_epg:match('<div class="root_r1ru04lg time_t1krzpy3.-root_subtitle2_r18emsye">(.-)</div>') or ''
	timein_h, timein_m = te[ie].time_in:match('^(%d+):(%d+)$')
	timein = timein_h*60*60 + timein_m*60
	for answer_data in answer:gmatch('<label for=".-</label>') do
	if answer_data:match('checked') then
	timein_data = answer_data:match('value="(%d+)"')
	end
	end
	timein = timein + timein_data
--	timein = timein + timein_data - (24*60*60)
	te[ie].age_info = answer_epg:match('<span class="root_r1ru04lg info_i2qcqnp root_caption1_r82cf8x">(.-)</span>') or ''
	te[ie].poster = answer_epg:match('src="(.-)"')
	te[ie].adress = inAdr:gsub('?program=.-&start_time=.-$', '') .. '?start_time=' .. timein
--	te[ie].adress = te[ie].adress .. '?program=' .. p_shift .. '&start_time=' .. t_shift
	if te[ie].islive == '1'
		then
			te[ie].time_play = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. te[ie].adress:gsub('?.-$', '') ..
			'\')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/play.png" height="' .. 36*masshtab .. '" align="top">'
			poster1 = te[ie].poster:gsub('176x132', '704x528')
	elseif te[ie].islive == '' and lable_notarchiv == ''
		then
			te[ie].time_play = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. te[ie].adress ..
			'\')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/archive.png" height="' .. 36*masshtab .. '" align="top"></a>'
		else te[ie].time_play = ''
	end
	desc_e = desc_e .. '<table width="' .. 720*masshtab .. '"><tr><td style="padding: 5px 5px 0px; color: #EBEBEB;" width="' .. 220*masshtab ..
			'"><img src="' .. te[ie].poster .. '" height = "' .. 120*masshtab .. '" width = "' .. 208*masshtab ..
			'"></td><td style="padding: 5px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h3>' .. te[ie].name_str ..
			'</h3><h4>' .. te[ie].time_play .. ' <font color=#CD7F32>' .. te[ie].time_in  .. '</font></h4><h4>' .. te[ie].age_info ..
			'</h4></td></tr></table><table width="99%%"><tr><td style="padding: 5px 5px 0px; color: #EBEBEB;"><h5>' .. te[ie].info .. '</h5></td></tr></table><hr>'
	ie = ie + 1
end
		require 'json'
		local path = './luaScr/user/westSide/zapros/list_channels.json'
		local file = io.open('./luaScr/user/westSide/zapros/list_channels.json', 'r')
			if not file then 
			m_simpleTV.OSD.ShowMessage_UTF8( path )			
			else
		local answer_pls = file:read('*a')
		file:close()			
		local t_pls, i_pls, t1_address, t1_desc, t1_name  = {}, 1, '', '', ''
		answer_pls = answer_pls:gsub('%[%]', '""')
		
			local tab_pls = json.decode(answer_pls)
			while tab_pls.channels_list[i_pls] do					
					t_pls[i_pls] = {}
					t_pls[i_pls].name = tab_pls.channels_list[i_pls].bcname
					t_pls[i_pls].name = t_pls[i_pls].name
					t_pls[i_pls].address = tab_pls.channels_list[i_pls].smlOttURL
					t_pls[i_pls].desc = tab_pls.channels_list[i_pls].bcdesc	or ''
							
					if t_pls[i_pls].name == title:gsub('коллекция', 'Коллекция') then 
					t1_address = t_pls[i_pls].address
					t1_desc = t_pls[i_pls].desc
					t1_name = t_pls[i_pls].name
					end 
				i_pls = i_pls + 1
			end
--			m_simpleTV.OSD.ShowMessageT({text = title .. ' | ' .. t1_name .. ' | ' .. t1_address .. ' | ' .. t1_desc, showTime = 1000 * 50})	
			
		local t_pls_desc = t1_desc or ''
		local t_pls_address = t1_address
--		retAdr = t_pls_address 
		timestamp = os.time() -- текущее Unix время
		program_start_time = inAdr:match('start_time=(%d+)$') -- время начало передачи
		if program_start_time then
		offset = timestamp - program_start_time -- таймшифт в секундах
		retAdr = t_pls_address .. '?offset=-' .. offset -- адрес на воспроизведение с таймшифтом
		else retAdr = t_pls_address 
		end
		

			te[1] = {}
					te[1].Id = 1
					te[1].Name = title:gsub('&quot;', '"')
					te[1].Address = retAdr	
					te[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. desc_e .. '</html>'
					te[1].InfoPanelDesc = te[1].InfoPanelDesc:gsub('"', '\"')
					te[1].InfoPanelName = te[1].Name
					te[1].InfoPanelTitle = t_pls_desc
					te[1].InfoPanelShowTime = 30000
					te[1].InfoPanelLogo = logo
			m_simpleTV.User.Wink.Tab = te
					m_simpleTV.OSD.ShowSelect_UTF8('Wink_info', 0, te, 8000, 32 + 64 + 128)
			if not te then
			m_simpleTV.OSD.ShowMessageT({text = 'Wink', showTime = 1000 * 5, id = 'channelName'})
			end
	
--		if inAdr:match('https://wink.rt.ru/tv/265')
--		then
--		m_simpleTV.Control.CurrentAddress = 'https://zabava-htlive.cdn.ngenix.net/hls/CH_TV1000RUSSKOEKINOHD/variant.m3u8'
--		else
		m_simpleTV.Control.CurrentAddress = retAdr
--		end
--		inAdr = background_chanel
		te.ExtButton1 = {ButtonEnable = true, ButtonName = '❌', ButtonScript = 'm_simpleTV.Control.ExecuteAction(37)'}
		te.ExtParams = {}
		te.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_Wink'
		te.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_Wink'
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(logo, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title:gsub('&quot;', '"'), m_simpleTV.Control.ChannelID, true)
	end
		m_simpleTV.Control.SetTitle(title)
		m_simpleTV.Control.CurrentTitle_UTF8 = title
--		m_simpleTV.OSD.ShowMessageT({text = title:gsub('&quot;', '"'), showTime = 1000 * 5, id = 'channelName'})
		if inAdr == background_chanel then
		m_simpleTV.Control.ExecuteAction(108,0)
		m_simpleTV.Control.ExecuteAction(108,1) 
		end
end
end
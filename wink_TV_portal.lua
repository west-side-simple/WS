-- видеоскрипт для Portal Wink TV v.2.3 25.10.2020
	if m_simpleTV.Control.ChangeAddress ~= 'No' then return end
	if not m_simpleTV.Control.CurrentAddress:match('^https://wink%.rt%.ru/tv$')
		and not m_simpleTV.Control.CurrentAddress:match('^https://wink%.rt%.ru/tv.+') then
		return
	end
	local inAdr = m_simpleTV.Control.CurrentAddress
	m_simpleTV.Control.ChangeAddress = 'Yes'
	m_simpleTV.Control.CurrentAddress = ''
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 1000, id = 'channelName'})
	program_start_time = inAdr:match('start_time=(%d+)$')
	if program_start_time then m_simpleTV.Control.PlayAddressT({address=inAdr:gsub('%?.-$', ''),timeshiftOffset=(os.time()-program_start_time)*1000}) else
	retAdr = inAdr:gsub('%?.-$', '') end
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
	portal1_str = '<h3><center>' .. titul_rezka_tor .. titul_hevc .. titul_lostfilm .. titul_yt .. titul_rezka .. titul_wink .. '</h3><hr>'

	local userAgent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'
	local session = m_simpleTV.Http.New(userAgent)
		if not session then return end
	m_simpleTV.Http.SetTimeout(session, 12000)
	if not m_simpleTV.User.Wink then
		m_simpleTV.User.Wink = {}
	end

	inAdr = m_simpleTV.Common.multiByteToUTF8(inAdr:gsub('%?start.-$', ''):gsub('%?program.-$', ''))

	local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr:gsub('%?start.-$', ''):gsub('%?program.-$', '')})
--	m_simpleTV.Http.Close(session)
		if rc ~= 200 then return end

		local function Get_address(title)
		require 'json'
		local path = './luaScr/user/westSide/zapros/list_channels.json'
		local file = io.open('./luaScr/user/westSide/zapros/list_channels.json', 'r')
			if not file then
			m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path) return end
		local answer_pls = file:read('*a')
		file:close()
		local t_pls, i_pls, t1_address, t1_desc, t1_name  = {}, 1, '', '', ''
		answer_pls = answer_pls:gsub('%[%]', '""')
			local tab_pls = json.decode(answer_pls)
			while tab_pls.channels_list[i_pls] do
					t_pls[i_pls] = {}
					t_pls[i_pls].name = tab_pls.channels_list[i_pls].bcname
					t_pls[i_pls].name = t_pls[i_pls].name:gsub('\\', ''):gsub('5 канал', 'Пятый канал')
					t_pls[i_pls].address = tab_pls.channels_list[i_pls].smlOttURL
					t_pls[i_pls].desc = tab_pls.channels_list[i_pls].bcdesc	or ''
					if t_pls[i_pls].name == title:gsub('коллекция', 'Коллекция'):gsub('Love Nature 4K', 'Love Nature 4K'):gsub('Матч ТВ', 'Матч ТВ HD'):gsub('5 канал', 'Пятый канал')
					or t_pls[i_pls].name:match('Известия') and title:match('Известия') or t_pls[i_pls].name:match('мужское') and title:match('Мужское') or t_pls[i_pls].name:match('Ювелирочка') and title:match('Ювелирочка')
					then
					t1_address = t_pls[i_pls].address:gsub('s37630','zabava-htlive')
					t1_desc = t_pls[i_pls].desc
					t1_name = t_pls[i_pls].name
					end
				i_pls = i_pls + 1
		end
			return t1_address
		end
----------------logo background
		if inAdr == 'https://wink.rt.ru/tv' or inAdr:match('https://wink%.rt%.ru/tv%?theme=')
		then
			background_epg = './luaScr/user/westSide/icons/Channels.jpg'
		else
			for answer_data1 in answer:gmatch('<label for=".-</label>') do
				if answer_data1:match('checked') then
					timein_data1 = answer_data1:match('value="(%d+)"')
				end
			end
			program_start = os.time() - m_simpleTV.Timeshift.EpgOffsetRequest / 1000
			data_stroka = program_start - timein_data1
			for answer_epg1 in answer:gmatch('<div class="root_r1ru04lg time_t1krzpy3.-</p>') do
				sitedata_stroka = answer_epg1:match('<div class="root_r1ru04lg time_t1krzpy3.->(.-)</div>')
				sitedata_stroka_hor, sitedata_stroka_min = sitedata_stroka:match('^(%d+)%:(%d+)$')
				sitedata_stroka_sec = sitedata_stroka_hor*60*60 + sitedata_stroka_min*60
				if sitedata_stroka_sec <= data_stroka then
					background_epg = answer_epg1:match('src="(.-)"')
					background_epg = background_epg:gsub('176x132', '704x528')
				end
			end
		end
	m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = background_epg, TypeBackColor = 0, UseLogo = 3, Once = 1})
------------------------------
	title = answer:match('property="og:title" content="(.-)"')
	title = title:gsub('&quot;','"'):gsub('&amp;','&')
	answer_group = answer:match('<div class="scroll_s8pomy7">(.-)</div></form>')

	local tg, j, kg, desc_g, name_grp = {}, 1, 1, '', ''
	for ww in answer_group:gmatch('(<label for=.-)</label>') do

	tg[j] = {}
	tg[j].name = ww:match('<span.->(.-)</span>') or 'Wink'
	tg[j].logo = 'simpleTVImage:./luaScr/user/westSide/genres_tv/' .. tg[j].name .. '.png'
	tg[j].adr = ww:match('<label for="(.-)"')
	if tg[j].name and tg[j].adr
	then
	tg[j].adr = 'https://wink.rt.ru/tv?theme=' .. tg[j].adr
	if tg[j].name == 'Все' then tg[j].adr = 'https://wink.rt.ru/tv' end
			if kg == 7 then
				desc_g = desc_g .. '</tr><tr>' kg = 1
			end
				if tg[j].adr == inAdr then
				desc_g = desc_g .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. tg[j].adr ..
				'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. tg[j].logo .. '" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab ..
				'"><h5><center><font color=#ED4830>' .. tg[j].name .. ' </font></h5></a></td>'
				name_grp = tg[j].name
				else
				desc_g = desc_g .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. tg[j].adr ..
				'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. tg[j].logo .. '" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab ..
				'"><h5><center><font color=#EBEBEB>' .. tg[j].name .. ' </font></h5></a></td>'
				end
		j = j + 1
		kg = kg + 1
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
---	desc plus
		local path1 = './luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u'
		local file1 = io.open('./luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u', 'r')
			if not file1 then
			m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path1) return end
		local answer_pls1 = file1:read('*a')
		file1:close()
		local t_pls1, i_pls1, k_pls1, desc_plus = {}, 1, 1, ''
			for tab_pls1 in answer_pls1:gmatch('group%-title=".-".-tvg%-logo=".-".-https://wink%.rt%.ru/tv/%d+') do
			t_pls1[i_pls1] = {}
			t_pls1[i_pls1].name_grp1, t_pls1[i_pls1].logo_pls1, t_pls1[i_pls1].adr_pls1 = tab_pls1:match('group%-title="(.-)".-tvg%-logo="(.-)".-(https://wink%.rt%.ru/tv/%d+)')
			if t_pls1[i_pls1].name_grp1:match(name_grp) and not t_pls1[i_pls1].name_grp1:match('UltraHD') or name_grp == 'Все' or name_grp == '4К (UltraHD)' and t_pls1[i_pls1].name_grp1:match('UltraHD') then
			if k_pls1 == 7 then
				desc_plus = desc_plus .. '</tr><tr>' k_pls1 = 1
			end
				desc_plus = desc_plus .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls1[i_pls1].adr_pls1 ..
				'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. t_pls1[i_pls1].logo_pls1 .. '" height = "' .. 80*masshtab .. '" width = "' .. 140*masshtab .. '"></a></td>'
				k_pls1 = k_pls1 + 1
				i_pls1 = i_pls1 + 1
			end
		end
		if desc_plus ~= '' then desc_plus = '<table><tr>' .. desc_plus .. '</tr></table>' end
-------------
			t[1] = {}
					t[1].Id = 1
					t[1].Name = title
					t[1].Address = background_chanel
					t[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. '<table width="99\%"><tr>' .. desc_g .. '</tr></table>' ..	desc .. '</tr></table><hr></html><html>' .. desc_plus .. '</body></html>'
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
		if inAdr == background_chanel then
		m_simpleTV.Control.ExecuteAction(108,0)
		m_simpleTV.Control.ExecuteAction(108,1) end
elseif answer:match('<div data%-test="channel%-content" class="root_rf3liu8 content_c1etjow5">')
then
local title = answer:match('<h1 class="root_r1ru04lg title_t1kbub20 root_header1_r1swja1w" data%-test="media%-item%-name">(.-)<')
title = title:gsub('&quot;', '"'):gsub('&amp;', '&')
local title_grp = answer:match('<h3 class="root_r1ru04lg subtitle_s12vmtjp root_caption1_.-">(.-)<') or 'Wink TV'

if title == 'Супер' then title_grp = 'Эфирные, Кино и сериалы, Развлекательные' end

--строка Гид
-- todo
---------------
--строка крошек
local title_grp_all = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Все.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Все</font></h5></a></td>'
local group_td_178 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=178\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/4К (UltraHD).png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>4К (UltraHD)</font></h5></a></td>'
local group_td_2 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=2\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/HD.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>HD</font></h5></a></td>'
local group_td_4 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=4\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Эфирные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Эфирные</font></h5></a></td>'
local group_td_12 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=12\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Спортивные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Спортивные</font></h5></a></td>'
local group_td_11 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=11\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Кино и сериалы.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Кино и сериалы</font></h5></a></td>'
local group_td_5 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=5\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Развлекательные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Развлекательные</font></h5></a></td>'
local group_td_3 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=3\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Информационные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Информационные</font></h5></a></td>'
local group_td_13 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=13\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Детские.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Детские</font></h5></a></td>'
local group_td_6 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=6\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Познавательные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Познавательные</font></h5></a></td>'
local group_td_7 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=7\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Музыкальные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Музыкальные</font></h5></a></td>'
local group_td_10 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=10\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Взрослые.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Взрослые</font></h5></a></td>'
local group_td_8 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=8\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Телемагазины.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Телемагазины</font></h5></a></td>'
local group_td_179 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=179\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Радио.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Радио</font></h5></a></td>'
local group_td_73 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=73\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Здоровье.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Здоровье</font></h5></a></td>'
local group_td_69 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=69\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Бесплатные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Бесплатные</font></h5></a></td>'
local group_td_173 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=173\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Кулинарные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Кулинарные</font></h5></a></td>'
local group_td_9 = '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/tv?theme=9\')" style="color: #EBEBEB; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/genres_tv/Региональные.png" height = "' .. 50*masshtab .. '" width = "' .. 125*masshtab .. '"><h5><center><font color=#EBEBEB>Региональные</font></h5></a></td>'
if title_grp:match('4К') then title_grp_all = title_grp_all .. group_td_178 end
if title_grp:match('HD') and not title_grp:match('4К') then title_grp_all = title_grp_all .. group_td_2 end
if title_grp:match('Эфирные') then title_grp_all = title_grp_all .. group_td_4 end
if title_grp:match('Спортивные') then title_grp_all = title_grp_all .. group_td_12 end
if title_grp:match('Кино и сериалы') then title_grp_all = title_grp_all .. group_td_11 end
if title_grp:match('Развлекательные') then title_grp_all = title_grp_all .. group_td_5 end
if title_grp:match('Информационные') then title_grp_all = title_grp_all .. group_td_3 end
if title_grp:match('Детские') then title_grp_all = title_grp_all .. group_td_13 end
if title_grp:match('Познавательные') then title_grp_all = title_grp_all .. group_td_6 end
if title_grp:match('Музыкальные') then title_grp_all = title_grp_all .. group_td_7 end
if title_grp:match('Взрослые') then title_grp_all = title_grp_all .. group_td_10 end
if title_grp:match('Телемагазины') then title_grp_all = title_grp_all .. group_td_8 end
if title_grp:match('Радио') then title_grp_all = title_grp_all .. group_td_179 end
if title_grp:match('Здоровье') then title_grp_all = title_grp_all .. group_td_73 end
if title_grp:match('Бесплатные') then title_grp_all = title_grp_all .. group_td_69 end
if title_grp:match('Кулинарные') then title_grp_all = title_grp_all .. group_td_173 end
if title_grp:match('Региональные') then title_grp_all = title_grp_all .. group_td_9 end
group_str = '<table><tr>' .. title_grp_all .. '</tr></table>'
---------------
local title_desc = answer:match('{"left":0,"total":0},".-","(.-)"') or title_grp
title_desc = title_desc:gsub('\\', '')
if title_desc == 'age_value' then title_desc = title_grp end
 logo = answer:match('<div class="poster_pbugp4u.-src="(.-)"')
 retAdr = Get_address(title)
local te, ie, ke, desc_e = {}, 1, 1, ''
local p_shift, t_shift, lable_notarchiv = '', '', ''
for answer_epg in answer:gmatch('<div class="root_r1ru04lg time_t1krzpy3.-</p>') do
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
	te[ie].name = answer_epg:match('<h3 class="root_r1ru04lg.->(.-)</h3>')
	rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. te[ie].name .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
	yt_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'-' .. te[ie].name .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
	te[ie].name_str = te[ie].name .. rezka_poisk .. yt_poisk
	te[ie].info = answer_epg:match('<p class="root_r1ru04lg.->(.-)</p>') or ''
	te[ie].time_in = answer_epg:match('<div class="root_r1ru04lg.->(.-)</div>') or ''	
	timein_h, timein_m = te[ie].time_in:match('^(%d+):(%d+)$')
	timein = timein_h*60*60 + timein_m*60
	for answer_data in answer:gmatch('<label for=".-</label>') do
	if answer_data:match('checked') then
	timein_data = answer_data:match('value="(%d+)"')
	end
	end
	te[ie].start = timein + timein_data
	te[ie].age_info = answer_epg:match('<span class="root_r1ru04lg.->(.-)</span>') or ''
	te[ie].poster = answer_epg:match('src="(.-)"') or logo
	te[ie].adress = inAdr:gsub('%?.-$', '')
	if te[ie].islive == '1'
		then
			te[ie].time_play = '<a href = "simpleTVLua:play_timeshift_adr(' .. te[ie].start  .. ')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/archive.png" height="' .. 36*masshtab ..
			'" align="top"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. te[ie].adress ..
			'\')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/play.png" height="' .. 36*masshtab .. '" align="top">'
			poster1 = te[ie].poster:gsub('176x132', '704x528')
	elseif te[ie].islive == '' and lable_notarchiv == ''
		then
		te[ie].time_play = '<a href = "simpleTVLua:play_timeshift_adr(' .. te[ie].start  .. ')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/archive.png" height="' .. 36*masshtab .. '" align="top"></a>'
		poster1 = te[ie].poster:gsub('176x132', '704x528')
		else te[ie].time_play = ''
	end
	desc_e = desc_e .. '<table width="' .. 720*masshtab .. '"><tr><td style="padding: 5px 5px 0px; color: #EBEBEB;" width="' .. 220*masshtab ..
			'"><img src="' .. te[ie].poster .. '" height = "' .. 120*masshtab .. '" width = "' .. 208*masshtab ..
			'"></td><td style="padding: 5px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h3>' .. te[ie].name_str ..
			'</h3><h4>' .. te[ie].time_play .. ' <font color=#CD7F32>' .. te[ie].time_in  .. ' МСК</font></h4><h4>' .. te[ie].age_info ..
			'</h4></td></tr></table><table width="99%%"><tr><td style="padding: 5px 5px 0px; color: #EBEBEB;"><h5>' .. te[ie].info .. '</h5></td></tr></table><hr>'
	ie = ie + 1
end

--time stamps
		local pars, i, start_prev, start_next = {}, 1, '', ''
		for w0 in answer:gmatch('"original_id":%d+,.-"start_time":%d+,"end_time":%d+,') do
			pars[i] = {}
			pars[i].original_id, pars[i].start_time_from_page, pars[i].end_time_from_page = w0:match('"original_id":(%d+),.-"start_time":(%d+),"end_time":(%d+),')
			if tonumber(program_start) >= tonumber(pars[i].start_time_from_page) and tonumber(program_start) < tonumber(pars[i].end_time_from_page) then
				start_next = pars[i].end_time_from_page
			end
			if tonumber(program_start) - 60 >= tonumber(pars[i].start_time_from_page) and tonumber(program_start) - 60 < tonumber(pars[i].end_time_from_page) then
				start_prev = pars[i].start_time_from_page
			end
			i = i + 1
		end
--------------

			te[1] = {}
					te[1].Id = 1
					te[1].Name = title:gsub('&quot;', '"')
					te[1].Address = retAdr
					te[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal1_str .. group_str .. desc_e .. '</html>'
					te[1].InfoPanelDesc = te[1].InfoPanelDesc:gsub('"', '\"')
					te[1].InfoPanelName = te[1].Name
					te[1].InfoPanelTitle = title_desc
					te[1].InfoPanelShowTime = 30000
					te[1].InfoPanelLogo = logo
			m_simpleTV.User.Wink.Tab = te

			if not te then
			m_simpleTV.OSD.ShowMessageT({text = 'Wink', showTime = 1000 * 5, id = 'channelName'})
			end
			m_simpleTV.Control.CurrentAddress = retAdr
		te.ExtParams = {}
		if m_simpleTV.User.paramScriptForSkin_buttonPrev then
			te.ExtButton0 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonPrev, ButtonScript = 'play_timeshift_adr(' .. start_prev  .. ')'}
		else
			te.ExtButton0 = {ButtonEnable = true, ButtonName = '', ButtonScript = 'play_timeshift_adr(' .. start_prev  .. ')'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			te.OkButton = {ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonNext then
			te.ExtButton1 = {ButtonEnable = true, ButtonImageCx = masshtab*30, ButtonImageCy = masshtab*30, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonNext, ButtonScript = 'play_timeshift_adr(' .. start_next  .. ')'}
		else
			te.ExtButton1 = {ButtonEnable = true, ButtonName = '', ButtonScript = 'play_timeshift_adr(' .. start_next  .. ')'}
		end

		m_simpleTV.OSD.ShowSelect_UTF8('Wink_info', 0, te, 8000, 32 + 64 + 128)

	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(logo, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title:gsub('&quot;', '"'), m_simpleTV.Control.ChannelID, true)
	end
		m_simpleTV.Control.SetTitle(title)
		m_simpleTV.Control.CurrentTitle_UTF8 = title
		if inAdr == background_chanel then
		m_simpleTV.Control.ExecuteAction(108,0)
		m_simpleTV.Control.ExecuteAction(108,1)
		end
end
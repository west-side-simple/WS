
function showTestWestSide(channelId)
 if channelId==-1 then return end
--:gsub(' HD', ''):gsub(' SD', '')
 local answer_all_epg = ''
 local t = m_simpleTV.Database.GetTable('SELECT * FROM channels WHERE Id==' .. channelId)
 if   t == nil
   or t[1] == nil
  then
 return
 end
-------------------------
		local masshtab = m_simpleTV.User.paramScriptForSkin_masshtab or 1
		if m_simpleTV.User.paramScriptForSkin_background_chanel then
			background_chanel = m_simpleTV.User.paramScriptForSkin_background_chanel
		else
			background_chanel = 'https://radio-stream-1.obozrevatel.com/radiorelaxfm128.mp3'
		end
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
		local titul_wink = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/movies\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuWINK.png" height="' .. 36*masshtab .. '" align="top"></a>'
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
	if Weather then
		local pogoda = Weather.api.GetCurTemp()
		if type(pogoda)=="table" then
			pogoda_cur_temp = pogoda.cur_temp
			pogoda_letter = pogoda.letter
			pogoda_cur_icon = pogoda.cur_icon
			if pogoda.cur_icon == '' then pogoda_cur_icon = 'simpleTVImage:./luaScr/user/Weather/iconset/light/na.png' end
			pogoda_str = '<td style="padding: 10px 10px 5px; vertical-align: middle; color: #EBEBEB;"><h3><center><a href = "simpleTVLua:dofile(m_simpleTV.MainScriptDir .. \'user/Weather/switch_weather.lua\')"><img src="' .. pogoda_cur_icon .. '" height="' .. 36*masshtab .. '" align="top"></a>' ..	pogoda_cur_temp .. pogoda_letter .. '</h3></td>'
		else m_simpleTV.OSD.ShowMessage_UTF8("установите дополнение ПОГОДА")
			pogoda_str = ''
		end
	else m_simpleTV.OSD.ShowMessage_UTF8("дополнение ПОГОДА не установлено")
			pogoda_str = ''
	end
	portal_str = '<table width="' .. 720*masshtab .. '"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><h3><center>' ..
	titul_rezka_tor .. titul_hevc .. titul_lostfilm ..' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_wink ..
	'</h3></td>' .. pogoda_str .. '</tr></table><hr>'
------------------------
local function archive(answer_all_epg)
	local te, ie = {}, 1
	for answer_epg in answer_all_epg:gmatch('<div class="root_r1ru04lg time_t1krzpy3.-</p>') do
		te[ie] = {}
		te[ie].name = answer_epg:match('<h3 class="root_r1ru04lg.->(.-)</h3>')
		te[ie].info = answer_epg:match('<p class="root_r1ru04lg.->(.-)</p>') or ''
		te[ie].time_in = answer_epg:match('<div class="root_r1ru04lg.->(.-)</div>') or ''
		timein_h, timein_m = te[ie].time_in:match('^(%d+):(%d+)$')
		te[ie].timein = timein_h*60*60 + timein_m*60
		te[ie].age_info = answer_epg:match('<span class="root_r1ru04lg.->(.-)</span>') or ''
		te[ie].poster = answer_epg:match('src="(.-)"') or logo1
		te[ie].adress = url
		ie = ie + 1
	end
	local rev_te = {}
	for ie=#te, 1, -1 do
		rev_te[#rev_te+1] = te[ie]
	end

	for ie=1, #rev_te, 1 do

		if ie==1
		then
			rev_te[ie].time_all = 24*60*60 - rev_te[ie].timein
		else
			rev_te[ie].time_all = rev_te[ie-1].timein - rev_te[ie].timein
		end
		if rev_te[ie].time_all < 0 then
			rev_te[ie].time_all = rev_te[ie].time_all + 24*60*60
			timein_data1 = timein_data1 - 24*60*60
		end
		rev_te[ie].time_all_str = math.floor(rev_te[ie].time_all/60)
		rev_te[ie].time_start = timein_data1 + rev_te[ie].timein
		rev_te[ie].time_end = rev_te[ie].time_start + rev_te[ie].time_all
	end

	local n, arc1 = 1, {}
	for n=1, #rev_te, 1 do
		arc1[n] = {}
		if rev_te[n].time_start <= os.time() and rev_te[n].time_start > os.time() - 3*24*60*60
			then
--			rev_te[ie].time_play = '<a href = "simpleTVLua:play_adr_timeshift(' .. channelId .. ', ' .. rev_te[ie].time_start  .. ', \'' .. rev_te[ie].poster:gsub('176x132', '704x528')  .. '\')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/archive.png" height="' .. 36*masshtab .. '" align="top"></a>'
			arc1[n] = rev_te[n]
		end
	end
-----------
		local hash, arc2 = {}, {}
			for k = 1, #arc1 do
				if arc1[k].name and not hash[arc1[k].name]
				then
					arc2[#arc2 + 1] = arc1[k]
					hash[arc1[k].name] = true
				end
			end
		table.sort(arc2, function(a, b) return a.name < b.name end)
		local desc_e = ''
		for ie = 1, #arc2 do
		arc2[ie].time_play = '<a href = "simpleTVLua:play_adr_timeshift(' .. channelId .. ', ' .. arc2[ie].time_start  .. ', \'' .. arc2[ie].poster:gsub('176x132', '704x528')  .. '\')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/archive.png" height="' .. 36*masshtab .. '" align="top"></a>'
		rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. arc2[ie].name .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
		yt_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'-' .. arc2[ie].name .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
		arc2[ie].name_str = arc2[ie].name .. rezka_poisk .. yt_poisk
		desc_e = desc_e .. '<table width="' .. 720*masshtab .. '"><tr><td style="padding: 5px 5px 0px; color: #EBEBEB;" width="' .. 220*masshtab ..
			'"><img src="' .. arc2[ie].poster .. '" height = "' .. 120*masshtab .. '" width = "' .. 208*masshtab ..
			'"></td><td style="padding: 5px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h3>' .. arc2[ie].name_str ..
			'</h3><h4>' .. arc2[ie].time_play .. ' <font color=#CD7F32> (' .. arc2[ie].time_all_str ..
			' мин.) ' .. os.date("%a %d %b %Y %H:%M", arc2[ie].time_start):gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб'):gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек') ..
			'</font></h4><h4>' .. arc2[ie].age_info .. '</h4></td></tr></table><table width="99%%"><tr><td style="padding: 5px 5px 0px; color: #EBEBEB;"><h5>' .. arc2[ie].info .. '</h5></td></tr></table><hr>'
end
	return desc_e
end
------------------------
  local desc_epg = ''
  local logo = t[1].Logo
  if logo == '' then
    logo = 'simpleTVImage:./luaScr/user/testWestSide/emptyLogo.png'
  elseif string.match(logo,'^%.%.') then
    logo = 'simpleTVImage:' .. logo
  end
------------------------
	local function xren(s)
			if not s then
			 return ''
			end
		s = s:lower()
		s = s:gsub('*', '')
		s = s:gsub('%s+', ' ')
		s = s:gsub('^%s*(.-)%s*$', '%1')
		local a = {
				{'А', 'а'}, {'Б', 'б'}, {'В', 'в'}, {'Г', 'г'}, {'Д', 'д'}, {'Е', 'е'}, {'Ж', 'ж'}, {'З', 'з'},
				{'И', 'и'},	{'Й', 'й'}, {'К', 'к'}, {'Л', 'л'}, {'М', 'м'}, {'Н', 'н'}, {'О', 'о'}, {'П', 'п'},
				{'Р', 'р'}, {'С', 'с'},	{'Т', 'т'}, {'Ч', 'ч'}, {'Ш', 'ш'}, {'Щ', 'щ'}, {'Х', 'х'}, {'Э', 'э'},
				{'Ю', 'ю'}, {'Я', 'я'}, {'Ь', 'ь'},	{'Ъ', 'ъ'}, {'Ё', 'е'},	{'ё', 'е'}, {'Ф', 'ф'}, {'Ц', 'ц'},
				{'У', 'у'}, {'Ы', 'ы'}, {':', ''}, {'!', ''}
				}
			for _, v in pairs(a) do
				s = s:gsub(v[1], v[2])
			end
	 return s
	end
------------------------
		local function Get_address(title)
		local path = './luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u'
		local file = io.open('./luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u', 'r')
			if not file then
			m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path) return end
		local answer_pls = file:read('*a')
		file:close()
		answer_pls = answer_pls:gsub('\n', '')
		local t_pls, i_pls, t1_address, t1_desc, t1_name  = {}, 1, '', '', ''
		local tab_pls = {}
		for pls in answer_pls:gmatch('#EXTINF:.-group%-title=".-".-group%-logo=".-".-tvg%-logo=".-".-update%-code=".-" ,.-https://wink%.rt%.ru/tv/%d+') do
					t_pls[i_pls] = {}
					t_pls[i_pls].name, t_pls[i_pls].address = pls:match('#EXTINF:.-group%-title=".-".-group%-logo=".-".-tvg%-logo=".-".-update%-code=".-" ,(.-)(https://wink%.rt%.ru/tv/%d+)')
					if xren(t_pls[i_pls].name:gsub(' UHD', ''):gsub(' HD', ''):gsub(' 4K', ''):gsub(' 4К', ''):gsub(' 4к', '')) == xren(title:gsub(' UHD', ''):gsub(' HD', ''):gsub(' 4K', ''):gsub(' 4К', ''):gsub(' 4к', ''))
					then
					t1_address = t_pls[i_pls].address
					end
				i_pls = i_pls + 1
		end
			return t1_address
		end
------------------------
if Get_address(t[1].Name) and Get_address(t[1].Name) ~= ''
  or t[1].Name == 'ViP Megahit'
  or t[1].Name == 'ViP Comedy'
  or t[1].Name == 'ViP Premiere'
  then
	local userAgent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36'
	local session = m_simpleTV.Http.New(userAgent)
		if not session then return end
	m_simpleTV.Http.SetTimeout(session, 30000)
	if t[1].Name:match('ViP Megahit') then
	url = 'https://wink.rt.ru/tv/505'
	elseif t[1].Name:match('ViP Comedy') then
	url = 'https://wink.rt.ru/tv/506'
	elseif t[1].Name:match('ViP Premiere') then
	url = 'https://wink.rt.ru/tv/504'
	end
	url = Get_address(t[1].Name)

	local rc, answer = m_simpleTV.Http.Request(session, {url = url})
	if rc ~= 200 then return end
			for answer_data1 in answer:gmatch('<label for=".-</label>') do
				if answer_data1:match('checked') then
					timein_data1 = answer_data1:match('value="(%d+)"')
					timein_data1 = tonumber(timein_data1)
				end
			end
	--time stamps
		local pars1, i = {}, 1
		for w1 in answer:gmatch('"original_id":%d+,.-"start_time":%d+,"end_time":%d+,') do
			pars1[i] = {}
			pars1[i].original_id, pars1[i].start_time_from_page, pars1[i].end_time_from_page = w1:match('"original_id":(%d+),.-"start_time":(%d+),"end_time":(%d+),')
			if timein_data1 >= tonumber(pars1[i].start_time_from_page) and timein_data1 < tonumber(pars1[i].end_time_from_page) then
			url_epg2 = url .. '?program=' .. pars1[i].original_id .. '&start_time=' .. pars1[i].start_time_from_page
			end
			i = i + 1
		end
		answer_all_epg = answer
		if url_epg2 then
		local rc, answer_epg2 = m_simpleTV.Http.Request(session, {url = url_epg2})
		if rc ~= 200 then return end
		answer_all_epg = answer_epg2 .. answer_all_epg
		local pars2, i = {}, 1
		for w2 in answer_epg2:gmatch('"original_id":%d+,.-"start_time":%d+,"end_time":%d+,') do
			pars2[i] = {}
			pars2[i].original_id, pars2[i].start_time_from_page, pars2[i].end_time_from_page = w2:match('"original_id":(%d+),.-"start_time":(%d+),"end_time":(%d+),')
			if timein_data1 - 24*60*60 >= tonumber(pars2[i].start_time_from_page) and timein_data1 - 24*60*60 < tonumber(pars2[i].end_time_from_page) then
			url_epg3 = url .. '?program=' .. pars2[i].original_id .. '&start_time=' .. pars2[i].start_time_from_page
			end
			i = i + 1
		end
		end
		if url_epg3 then
		local rc, answer_epg3 = m_simpleTV.Http.Request(session, {url = url_epg3})
		if rc ~= 200 then return end
		answer_all_epg = answer_epg3 .. answer_all_epg
		local pars3, i = {}, 1
		for w3 in answer_epg3:gmatch('"original_id":%d+,.-"start_time":%d+,"end_time":%d+,') do
			pars3[i] = {}
			pars3[i].original_id, pars3[i].start_time_from_page, pars3[i].end_time_from_page = w3:match('"original_id":(%d+),.-"start_time":(%d+),"end_time":(%d+),')
			if timein_data1 - 24*60*60*2 >= tonumber(pars3[i].start_time_from_page) and timein_data1 - 24*60*60*2 < tonumber(pars3[i].end_time_from_page) then
			url_epg4 = url .. '?program=' .. pars3[i].original_id .. '&start_time=' .. pars3[i].start_time_from_page
			end
			i = i + 1
		end
		end
		if url_epg4 then
		local rc, answer_epg4 = m_simpleTV.Http.Request(session, {url = url_epg4})
		if rc ~= 200 then return end
		answer_all_epg = answer_epg4 .. answer_all_epg
		end

			program_start = os.time()
			current_answer_epg = answer
			data_stroka1 = program_start - timein_data1

			if current_answer_epg then
			for answer_logo_epg1 in current_answer_epg:gmatch('<div class="root_r1ru04lg time_t1krzpy3.-</p>') do
				sitedata_stroka_epg1 = answer_logo_epg1:match('<div class="root_r1ru04lg time_t1krzpy3.->(.-)</div>')
				sitedata_stroka_hor_epg1, sitedata_stroka_min_epg1 = sitedata_stroka_epg1:match('^(%d+)%:(%d+)$')
				sitedata_stroka_sec_epg1 = sitedata_stroka_hor_epg1*60*60 + sitedata_stroka_min_epg1*60
				if sitedata_stroka_sec_epg1 <= data_stroka1 then
					background_epg = answer_logo_epg1:match('src="(.-)"')
					background_epg = background_epg:gsub('176x132', '704x528')
				end
			end

	logo = background_epg
end
	desc_epg = archive(answer_all_epg)

  end

 local epgTitle,epgDesc

 if t[1].EpgId~='' and  t[1].EpgId~='noepg' then

	local curTime = os.date('%Y-%m-%d %X')
	local sql = 'SELECT * FROM ChProg WHERE IdChannel=="' .. t[1].EpgId .. '"'
              .. ' AND StartPr <= "' .. curTime .. '" AND EndPr > "' .. curTime .. '"'
	local sql1 = 'SELECT * FROM ChProg WHERE IdChannel=="' .. t[1].EpgId .. '"'
              .. ' AND StartPr > "' .. curTime .. '"'
  --debug_in_file(sql)
  local epgT = m_simpleTV.Database.GetTable(sql), m_simpleTV.Database.GetTable(sql1)

  if     epgT~=nil
     and epgT[1]~=nil
   then
   epgTitle = epgT[1].Title
   epgDesc  = epgT[1].Desc
   StartFor = epgT[1].StartPr:gsub('-$--$--$', '')
   EndFor   = epgT[1].EndPr
  end
--	else return
 end

  if t[1].EpgId1~='' and  t[1].EpgId1~='noepg' then

	local curTime = os.date('%Y-%m-%d %X')

	local sql1 = 'SELECT * FROM ChProg WHERE IdChannel=="' .. t[1].EpgId .. '"'
              .. ' AND StartPr > "' .. curTime .. '"'
  --debug_in_file(sql1)
  local epgT1 = m_simpleTV.Database.GetTable(sql1)

  if  epgT1~=nil and epgT1[1]~=nil
   then
   epgTitle1 = epgT1[1].Title
   epgDesc1  = epgT1[1].Desc
  end
--	else return
	end

 if StartFor and EndFor then
 StartForN = StartFor:gsub('.- ', '')
 StartForH = StartForN:match('(.-):')
 StartForM = StartForN:match(':(.-):')
 EndForN = EndFor:gsub('.- ', '')
 EndForH = EndForN:match('(.-):')
 EndForM = EndForN:match(':(.-):')
 prtime = (EndForH * 60 + EndForM) - (StartForH * 60 + StartForM)
 if prtime < 0 then prtime = prtime + 24 * 60 end
 timeH = os.date ("%H")
 timeM = os.date ("%M")
 prendtime = (EndForH * 60 + EndForM) - (timeH * 60 + timeM)
 if prendtime < 0 then prendtime = prendtime + 24 * 60 end
 prendtime = math.floor((1 - prendtime / prtime) * 100 + 0.5)
 prendtime = '<img src="simpleTVImage:./luaScr/user/westSide/progress/p' .. prendtime .. '.png" height="' .. 54*masshtab .. '" align="top">'
 end

		local function clean_title(s)
			s = s:gsub('%(.-%)', ' ')
			s = s:gsub('%[.-%]', ' ')
			s = s:gsub('Х/ф', '')
			s = s:gsub('х/ф', '')
			s = s:gsub('М/ф', '')
			s = s:gsub('м/ф', '')
			s = s:gsub('М/с', '')
			s = s:gsub('м/с', '')
			s = s:gsub('Т/с', '')
			s = s:gsub('т/с', '')
			s = s:gsub('%d+%-.-$', ' ')
			s = s:gsub('Сезон.-$', '')
			s = s:gsub('сезон.-$', '')
			s = s:gsub('Серия.-$', '')
			s = s:gsub('серия.-$', '')
			s = s:gsub('%d+ с%-н.-$', '')
			s = s:gsub('%d+ с[%.]*$', '')
			s = s:gsub('%p', ' ')
			s = s:gsub('«', '')
			s = s:gsub('»', '')
			s = s:gsub('^%s*(.-)%s*$', '%1')
		 return s
		end
		local function PlayRezka(title)
		local w = clean_title(title)
			return ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. w .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
		end
		local function PlayYT(title)
		local w1 = clean_title(title)
			return ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'-' .. w1 .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
		end
 local str = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. '<table width="99%"><tr><td style="padding: 10px 10px 0px; color: #EBEBEB;"><img style="float:right;" src="' .. logo .. '" height="' .. 150*masshtab .. '">'
        .. '<h2><a href = "simpleTVLua:play_adr_timeshift(' .. channelId .. ', ' .. os.time()  .. ', \'' .. logo .. '\')" style="color: #7FFFD4; text-decoration: none;"><img src="simpleTVImage:./luaScr/user/westSide/icons/play.png" height="' .. 36*masshtab .. '" align="top"></a><font color="#00FF7F">' .. t[1].Name .. '</font></h2>'
 if epgTitle then
		str = str .. '<h4><i><font color="#BBBBBB">' .. epgTitle .. '</font></i>' .. PlayRezka(epgTitle) .. PlayYT(epgTitle) .. '</h4><h4><font color="#CD7F32">(' .. StartForH .. ':' .. StartForM .. ' - '  .. EndForH .. ':' .. EndForM .. ')</font> <b>' .. prtime .. ' мин. </b>' .. prendtime .. '</h4></td></tr></table>'
 end

  if epgDesc then
   str = str .. '<table width="99%"><tr><td style="padding: 0px 10px 10px;" valign="middle" width="99%"><h5><font color="#EBEBEB">' .. epgDesc ..  '</font></h5><p><h4><font color="#CD7F32">далее: </font><i><font color="#BBBBBB">' .. epgTitle1 ..  PlayRezka(epgTitle1) .. PlayYT(epgTitle1) .. '</font></i></h4>'
 end

 str   =  str  .. '</td></tr></table>' .. desc_epg .. '</body></html>'

  debug_in_file(str)
 return '',str
end

local t ={}
t.Image = m_simpleTV.MainScriptDir_UTF8 .. 'user/testWestSide/fw_box_o.png'
t.EventFunction = "showTestWestSide"
t.IsTooltip = true
t.Mode = 7   --opt default=7 ( bitmask  1 - main playlist  2 - OSD playlist 4 - OSD playlist fullscreen)
t.DrawOnChannel = true   --opt default =true
t.DrawOnGroup   = true   --opt default =false
t.MediaMode =  -1 --opt default -1 (-1 all, 0 - channels, 1 - files, etc)
--t.StaticTooltip = m_simpleTV.Common.string_toUTF8('ќткрыть в PiP',1251)
--t.ExtFilterID = 0
--t.MaxSize =16   --opt default 0
 m_simpleTV.PlayList.AddItemButton(t)


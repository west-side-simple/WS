-- видеоскрипт для сайта http://newstudio.tv/ (20/11/20) - portal version
-- необходим: Acestream
-- авторы west_side, wafee
-- открывает любые ссылки с сайта
		if m_simpleTV.Control.ChangeAddress ~= 'No' then return end
	local inAdr = m_simpleTV.Control.CurrentAddress
		if not inAdr then return end
		if not inAdr:match('^https?://newstudio%.tv/') then return end
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 1000, id = 'channelName'})
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = '', TypeBackColor = 0, UseLogo = 0, Once = 1})
	end
	local function showError(str)
		m_simpleTV.OSD.ShowMessageT({text = 'newstudio ошибка: ' .. str, showTime = 5000, color = 0xffff1000, id = 'channelName'})
	end
	m_simpleTV.Control.ChangeAddress = 'Yes'
	m_simpleTV.Control.CurrentAddress = ''
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
		local titul_rezka = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.ag\')"><img src="https://rezka.ag/templates/hdrezka/images/hdrezka-logo.png" height="' .. 30*masshtab .. '" align="top"></a>'
		local titul_hevc = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/h265.png" height="' .. 30*masshtab .. '" align="top"></a>'
		local titul_rezka_tor = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="https://rezka.cc/apple-touch-icon.png" height="' .. 30*masshtab .. '" align="top"></a>'
		local titul_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/new\/\')"><img src="https://www.lostfilm.tv/favicon.ico" height="' .. 30*masshtab .. '" align="top"></a>'
		local titul_yt = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.youtube.com/feed/channels\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 30*masshtab .. '" align="top"></a>'
		local titul_wink = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/333\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuWINK.png" height="' .. 30*masshtab .. '" align="top"></a>'
		local titul_newstudio = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'http://newstudio.tv/\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/newstudio.png" height="' .. 30*masshtab .. '" align="top"></a>'
		local str_newstudio = '<table width="100%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;" align="center"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'http://newstudio.tv/\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/New.png" height="' .. 60*masshtab .. '" align="top"></a>' ..
	'<img src="simpleTVImage:./luaScr/user/westSide/icons/pixel.png" height="1" width="120">' ..
	'<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'http://newstudio.tv/tracker.php\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Serial_OnAir.png" height="' .. 60*masshtab .. '" align="top"></a>' ..
	'<img src="simpleTVImage:./luaScr/user/westSide/icons/pixel.png" height="1" width="120">' ..
	'<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'http://newstudio.tv/viewforum.php\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Serial_End.png" height="' .. 60*masshtab .. '" align="top"></a></td></tr></table><hr>'
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end

		if Weather and Weather.Param.enabled==1 then
		local pogoda = Weather.api.GetCurTemp()
		if type(pogoda)=="table" then
--			m_simpleTV.OSD.ShowMessage_UTF8( pogoda.cur_temp .. pogoda.letter .. '\n' .. pogoda.cur_icon)
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
	portal_str = '<table style="font-size: 32px;" width="100%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;" align="center">' ..
	titul_rezka_tor .. titul_hevc .. titul_lostfilm .. titul_newstudio .. ' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_wink ..
	'</td>' .. pogoda_str .. '</tr></table><hr>'

	local session = m_simpleTV.Http.New('Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.3729.121 Safari/537.36')
		if not session then
			showError('1')
		 return
		end
	m_simpleTV.Http.SetTimeout(session, 8000)
	local host = inAdr:match('(https?://.-)/')
	local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr})
		if rc ~= 200 then
			showError('2')
			m_simpleTV.Http.Close(session)
		 return
		end
	answer = answer:gsub('\n\n', ' '):gsub('\n', ' '):gsub('  ', '')
	local ser_adr_title, ser_title = answer:match('<li><a href="viewforum%.php%?f=(%d+)".-class="active">(.-)</a></li>')
	if ser_adr_title then ser_adr_title = 'http://newstudio.tv/tracker.php?f=' .. ser_adr_title else ser_adr_title = 'http://newstudio.tv/tracker.php' end
	local title = answer:match('<span class="post%-b">(.-)</span>') or ser_title or 'NewStudio'
	local cover = answer:match('background: url%(\'(/images/fones/.-%.jpg)\'%)') or ''
	cover = 'http://newstudio.tv/' .. cover
	if inAdr:match('/viewtopic%.php%?t=%d+') then
	name_rus = title:gsub(' /.-$', '')
	name_eng = title:gsub('^.-/ ', ''):gsub(' %(.-$', '')
	rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. name_eng:gsub(' %(.-$', ''):gsub('"', '') .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a></h4>'
	local cover = answer:match('<var class="postImg" title="(.-)"') or './luaScr/user/westSide/genres_colored/Foreign.png'
	cover = cover:gsub('http://', 'https://')
	answer_info1 = answer:match('<span class="post%-u">(.-)<span class="post%-b">О фильме:</span>') or ''
	answer_info1 = answer_info1:gsub('<span class="post%-br"><br /></span><span class="post%-br"><br /></span>', '')
	answer_info2 = answer:match('<span class="post%-b">(О фильме:</span>.-)<span class="post%-u">') or ''
	answer_info2 = answer_info2:gsub('<span class="post%-br"><br /></span><span class="post%-br"><br /></span>', '')
	if cover then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = cover, TypeBackColor = 0, UseLogo = 3, Once = 1})
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
	end
	answer_torrent = answer:match('<a href="(download%.php%?.-)"') or ''
	answer_torrent = 'http://newstudio.tv/' .. answer_torrent
--------------
	if not m_simpleTV.User then
		m_simpleTV.User = {}
	end
	if not m_simpleTV.User.Newstudio then
		m_simpleTV.User.Newstudio = {}
	end
	m_simpleTV.User.Newstudio.DelayedAddress = nil
	function OnMultiAddressOk_Newstudio(Object, id)
		if id == 0 then
			OnMultiAddressCancel_Newstudio(Object)
		else
			m_simpleTV.User.Newstudio.DelayedAddress = nil
		end
	end
	function OnMultiAddressCancel_Newstudio(Object)
		if m_simpleTV.User.Newstudio.DelayedAddress then
			local state = m_simpleTV.Control.GetState()
			if state == 0 then
				m_simpleTV.Control.SetNewAddress(m_simpleTV.User.Newstudio.DelayedAddress)
			end
			m_simpleTV.User.Newstudio.DelayedAddress = nil
		end
		m_simpleTV.Control.ExecuteAction(36, 0)
	end
	local retAdr
	rc, answer1 = m_simpleTV.Http.Request(session, {url = answer_torrent, writeinfile = true})
	m_simpleTV.Http.Close(session)
		if rc ~= 200 then
			showError('5')
		 return
		end
	retAdr = 'torrent://' .. answer1

	local tab = {}
	tab[1] = {}
	tab[1].Id = 1
	tab[1].Name = title
	tab[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background2 .. '><table width="100%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. ser_adr_title .. '\')"><img src="' .. cover ..
	'" width="' .. masshtab*240 .. '"></a></td><td style="padding: 10px 5px 0px; color: #EBEBEB; vertical-align: middle;"><h5><center>' .. titul_rezka_tor .. titul_hevc .. titul_lostfilm .. titul_newstudio .. titul_yt .. titul_rezka .. titul_wink ..
	'</h5><hr><h4><font color=#00FA9A>' .. name_rus .. rezka_poisk .. '</font></h4><h5><font color=#BBBBFB>' .. name_eng .. '</font></h5><h5>' .. answer_info1 .. '</h5></td></tr></table><table width="100%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><h5>' .. answer_info2 .. '</h5></td></tr></table></body></html>'
	tab[1].InfoPanelDesc = tab[1].InfoPanelDesc:gsub('"', "\"")
	tab[1].InfoPanelTitle = title
	tab[1].InfoPanelName = title
	tab[1].InfoPanelShowTime = 60000
	tab[1].InfoPanelLogo = cover
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_Newstudio()'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_Newstudio()'}
		end
	m_simpleTV.OSD.ShowSelect_UTF8(title, 0, tab, 8000, 32 + 64 + 128)
	m_simpleTV.Control.SetTitle(title)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.Control.CurrentAddress = retAdr

	--wafee
 local t = {}
 t.message = tab[1].InfoPanelDesc
 t.richTextMode = true
 t.header = tab[1].InfoPanelTitle
 t.showTime = 1000*60
 t.once = true
 --t.textAlignment = 1
 t.windowAlignment = 2
 t.windowMaxSizeH = 1
 t.windowMaxSizeV = 1

 if m_simpleTV.User.westSide.PortalTable==nil then
   m_simpleTV.User.westSide.PortalTable=t --кешируем данные в юзер таблицу
 end

else
--------------блок стены лого
			local name_s, adr_s, logo_s, desc_s, all_str = '','','','', ''
			if answer:match('<div class="torrent">') and not answer:match('<tr class="') then
			for w in answer:gmatch('<div class="torrent">.-</div> </div>') do
				name_s = w:match('<div class="tdesc">(.-)</div>')
				name_rus = name_s:gsub(' /.-$', '')
				name_eng = name_s:gsub('^.-/ ', ''):gsub('%).-$', ')')
				adr_s = w:match('<a href="(/viewtopic%.php%?t=%d+)"')
				adr_s = 'http://newstudio.tv' .. adr_s
				logo_s = w:match('<img src="(/images/posters/%d+%.jpg)"') or ''
				logo_s = 'http://newstudio.tv' .. logo_s
				desc_s = desc_s .. '<tr><td style="padding: 5px 5px 5px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adr_s ..
				'\')"><center><img src="' .. logo_s .. '" height = "' .. 80*masshtab .. '" width = "' .. 80*masshtab .. '"></a></td><td style="padding: 5px 5px 5px; color: #EBEBEB;"><h5><font color=#BBFBBB>' .. name_rus ..
				'</font></h5><h5><font color=#BBBBFB>' .. name_eng .. '</font></h5></td><tr>'
			end
			elseif answer:match('<tr class=".-</tr>') then
			for w in answer:gmatch('<tr class=".-</tr>') do
				name_s = w:match('<b>(.-)</b>')
				name_rus = name_s:gsub(' /.-$', '')
				name_eng = name_s:gsub('^.-/ ', ''):gsub('%).-$', ')')
				name_res = name_s:gsub('^.-%) ', '')
				if name_res:match('1080p') then name_res = '<img src="simpleTVImage:./luaScr/user/westSide/resolution/videofhd.png" height="' .. 36*masshtab .. '" align="top">'
				elseif name_res:match('720p') then name_res = '<img src="simpleTVImage:./luaScr/user/westSide/resolution/videohd.png" height="' .. 36*masshtab .. '" align="top">'
				else name_res = '<img src="simpleTVImage:./luaScr/user/westSide/resolution/videosd.png" height="' .. 36*masshtab .. '" align="top">'
				end
				adr_s = w:match('(/viewtopic%.php%?t=%d+)"')
				adr_s = 'http://newstudio.tv' .. adr_s
				logo_s = w:match('<img src="(/images/posters/%d+%.jpg)"') or ''
				logo_s = 'http://newstudio.tv' .. logo_s
				desc_s = desc_s .. '<tr><td style="padding: 5px 5px 5px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adr_s ..
				'\')"><center><img src="' .. logo_s .. '" height = "' .. 80*masshtab .. '" width = "' .. 80*masshtab .. '"></a></td><td style="padding: 5px 5px 5px; color: #EBEBEB;"><h5><font color=#BBFBBB>' .. name_rus ..
				'</font></h5><h5><font color=#BBBBFB>' .. name_eng .. '</font></h5>' .. name_res .. '</td><tr>'
			end
			elseif inAdr:match('viewforum%.php') and not inAdr:match('%?f=%d+') then
				local k_ser = 1
				for answer_all in answer:gmatch('(<li><a href="/viewforum%.php.-</a></li>)') do
				ser_name = answer_all:match('<a href=".-">(.-)</a>')
				ser_adr = answer_all:match('href="(.-)"')
				ser_adr = ser_adr:gsub('viewforum', 'tracker')
				ser_adr = 'http://newstudio.tv' .. ser_adr
				ser_logo =  answer_all:match('href="/viewforum%.php%?f=(%d+)"') or ''
				ser_logo = 'http://newstudio.tv/images/posters/' .. ser_logo .. '.jpg'
							if k_ser == 11 then
								all_str = all_str .. '</tr><tr>' k_ser = 1
							end
				all_str = all_str .. '<td style="padding: 5px 5px 5px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. ser_adr .. '\')" style="color: #BBBBBB; text-decoration: none;"><img src="' .. ser_logo .. '" height = "' .. 80*masshtab .. '" width = "' .. 80*masshtab .. '"><p>' .. ser_name .. '</a></td>'
				k_ser = k_ser + 1
				end
				if all_str ~= '' then
				desc_s = '<table style="float: left;font-size: 22px;color: #7FFFD4; text-decoration: none;" border="0"><tr>' .. all_str .. '</tr></table>'
				end
			end
------------------
	local page_str = ''
	for answer_page in answer:gmatch('(<li><a href="tracker%.php.-</a></li>)') do
	page_name = answer_page:match('<a href=".-">(.-)</a>')
	page_adr = answer_page:match('href="(.-)"')
	page_adr = 'http://newstudio.tv/' .. page_adr .. 'w'
	page_str = page_str .. ' • <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. page_adr .. 	'\')" style="color: #BBBBBB; text-decoration: none;">' .. page_name .. '</a>'
	end
	if page_str ~= '' then
	page_str = '<font color=#EBEBEB>Серфинг по страницам: </font>' .. page_str
	page_str = '<table width="100%"><tr><td style="padding: 5px 5px 5px; color: #EBEBEB;"><center><h4>' .. page_str .. '</h4></td></tr></table>'
	else page_str = ''
	end
------------------
	if desc_s and desc_s ~= ''
		then
			desc_s = '<table width="99%"><tr>' .. desc_s .. '</tr></table>'
		else
			desc_s = ''
	end
	local retAdr = background_chanel
	local tab = {}
	tab[1] = {}
	tab[1].Id = 1
	tab[1].Name = title
	tab[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. str_newstudio .. '<table width="100%"' .. desc_s .. '</table>' .. page_str .. '</body></html>'
	tab[1].InfoPanelDesc = tab[1].InfoPanelDesc:gsub('"', "\"")
	tab[1].InfoPanelTitle = title
	tab[1].InfoPanelName = title
	tab[1].InfoPanelShowTime = 60000
	tab[1].InfoPanelLogo = cover
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_Newstudio()'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_Newstudio()'}
		end
	m_simpleTV.OSD.ShowSelect_UTF8('NewStudio', 0, tab, 8000, 32 + 64 + 128)
	m_simpleTV.Control.SetTitle(title)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = cover, TypeBackColor = 0, UseLogo = 3, Once = 1})
		m_simpleTV.Control.ChangeChannelLogo(cover, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.CurrentTitle_UTF8 = title
	m_simpleTV.OSD.ShowMessageT({text = title, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
	m_simpleTV.Control.CurrentAddress = retAdr
--	m_simpleTV.Control.ExecuteAction(108,0)
--	m_simpleTV.Control.ExecuteAction(108,1)
--------------конец блока стены лого

--wafee
 local t = {}
 t.message = tab[1].InfoPanelDesc
 t.richTextMode = true
 t.header = tab[1].InfoPanelTitle
 t.showTime = 1000*60
 t.once = true
 --t.textAlignment = 1
 t.windowAlignment = 2
 t.windowMaxSizeH = 1
 t.windowMaxSizeV = 1

 if m_simpleTV.User.westSide.PortalTable==nil then
   m_simpleTV.User.westSide.PortalTable=t --кешируем данные в юзер таблицу
   show_portal_window() -- hotkey 'I'
 end
end
-- debug_in_file(retAdr .. '\n')

function showTestWestSide(channelId)
 if channelId==-1 then return end
--:gsub(' HD', ''):gsub(' SD', '')
 local t = m_simpleTV.Database.GetTable('SELECT * FROM channels WHERE Id==' .. channelId)
 if   t == nil
   or t[1] == nil
  then
 return
 end

  local logo = t[1].Logo
  if logo == '' then
    logo = 'simpleTVImage:./luaScr/user/testWestSide/emptyLogo.png'
  elseif string.match(logo,'^%.%.') then
    logo = 'simpleTVImage:' .. logo
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
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
	portal_str = '<table width="99\%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><h3><center>' ..
	titul_rezka_tor .. titul_hevc .. ' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3></td></tr><hr></table>'

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
 local str = '<html><body bgcolor="#434750" ' .. background2 .. '>' .. portal_str .. '<table width="99%"><tr><td style="padding: 10px 10px 0px; color: #EBEBEB;"><img style="float:right;" src="' .. logo .. '" height="' .. 150*masshtab .. '">'
        .. '<h3><font color="#00FF7F">' .. t[1].Name .. '</font></h3>'
 if epgTitle then
		str = str .. '<h4><i><font color="#BBBBBB">' .. epgTitle .. '</font></i>' .. PlayRezka(epgTitle) .. PlayYT(epgTitle) .. '<p><font color="#CD7F32">(' .. StartForH .. ':' .. StartForM .. ' - '  .. EndForH .. ':' .. EndForM .. ')</font> <b>' .. prtime .. ' мин.</b></h4>'
		.. '<p><h4><font color="#CD7F32">до окончания: </font><b>' .. prendtime .. ' мин.</b></h4></td></tr></table>'
 end

  if epgDesc then
   str = str .. '<table width="99%"><tr><td style="padding: 0px 10px 10px;" valign="middle" width="99%"><h5><font color="#EBEBEB">' .. epgDesc ..  '</font></h5><p><h4><font color="#CD7F32">далее: </font><i><font color="#BBBBBB">' .. epgTitle1 ..  PlayRezka(epgTitle1) .. PlayYT(epgTitle1) .. '</font></i></h4>'
 end

 str   =  str  .. '</td></tr></table></body></html>'

  debug_in_file(str)
 return '',str
end

local t ={}
t.Image = m_simpleTV.MainScriptDir_UTF8 .. 'user/testWestSide/fw_box_o.png'
t.EventFunction = "showTestWestSide"
t.IsTooltip = true
t.Mode = 7   --opt default=7 ( bitmask  1 - main playlist  2 - OSD playlist 4 - OSD playlist fullscreen)
t.DrawOnChannel = true   --opt default =true
t.DrawOnGroup   = false   --opt default =false
t.MediaMode =  0 --opt default -1 (-1 all, 0 - channels, 1 - files, etc)
--t.StaticTooltip = m_simpleTV.Common.string_toUTF8('ќткрыть в PiP',1251)
--t.ExtFilterID = 0
--t.MaxSize =16   --opt default 0
 m_simpleTV.PlayList.AddItemButton(t)


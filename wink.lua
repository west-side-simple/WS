--script for wink.rt.ru VOD (17/11/20) - portal version
-- авторы wafee, west_side
--поддерживается выбор качества видео с помощью аддона videotracks
--примеры адресов для запуска
--https://wink.rt.ru/media_items/104967810
--https://wink.rt.ru/media_items/105005099/105004855/105005648
--воспроизведение аудиокниг не поддерживается
------------------------------------------------------------------------------

if m_simpleTV.Control.ChangeAddress ~= 'No' then return end

local inAdr =  m_simpleTV.Control.CurrentAddress
if inAdr==nil then return end

if not string.match( inAdr, '^https://wink%.rt%.ru/media_items/.+' ) then return end
---------------------------------------------------------------------------
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
	titul_rezka_tor .. titul_hevc .. titul_lostfilm ..' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_wink ..
	'</td>' .. pogoda_str .. '</tr></table><hr>'

	portal1_str = '<table style="font-size: 32px;" width="100%"><tr><td style="padding: 10px 10px 0px; vertical-align: middle;"><center>' .. titul_rezka_tor .. titul_hevc .. titul_lostfilm .. titul_yt .. titul_rezka .. titul_wink .. '</td></tr></table><hr>'
---------------------------------------------------------------------------
m_simpleTV.Control.ChangeAddress='Yes'
m_simpleTV.Control.CurrentAddress = 'error'

local userAgent = "okhttp/3.14.4"
local session =  m_simpleTV.Http.New(userAgent, nil, false)
if session == nil then return end
------------------------------------------------------------------------------
local function get_qlty_name(id)

  local t={
  {2377438, 'SD'},
  {1000059, 'HD'},
  {48528946, 'FHD'},
  {81180663, 'UHD'},
  }

  for i, v in ipairs(t) do
     if tonumber(id)==v[1] then return v[2] end
  end
    return id
end
------------------------------------------------------------------------------
local function get_data_table(id)

  local url = 'https://fe.svc.iptv.rt.ru/CacheClientJson/json/VideoMovie/list_assets?ID=' .. id .. '&locationId=700001&deviceType=OTTSTB'

  local rc,answer = m_simpleTV.Http.Request(session,{url=url})
  m_simpleTV.Http.Close(session)
  if rc~=200 then return end

  --debug_in_file(answer .. '\n')

  require('json')

  answer = string.gsub(answer, '%[%]', '""')

  local tab = json.decode(answer)
  if tab == nil then return end

  local t={}

  for i=1, #tab.content[1].assets.asset do

     if tab.content[1].assets.asset[i].type == 'CONTENT' then

        name = get_qlty_name(tab.content[1].assets.asset[i].asset_type)
        adr = tab.content[1].assets.asset[i].ifn

        t[i]={}
        t[i].Id=i
        t[i].Qlty = name
        t[i].Name = name
        t[i].Address = 'https://zabava-htvod.cdn.ngenix.net/' .. adr
        --debug_in_file(t[i].Name .. '  ' .. t[i].Address .. '\n')

     end
 end

 if #t==0 then

  for i=1, #tab.content do

     if tab.content[i].assets.asset.type == 'CONTENT' then

        name = get_qlty_name(tab.content[1].assets.asset.asset_type)
        adr = tab.content[i].assets.asset.ifn

        t[i]={}
        t[i].Id=i
        t[i].Qlty = name
        t[i].Name = name
        t[i].Address = 'https://zabava-htvod.cdn.ngenix.net/' .. adr
        --debug_in_file(t[i].Name .. '  ' .. t[i].Address .. '\n')

     end
  end

 end

  table.sort(t, function(a, b) return a.Qlty < b.Qlty end)
  for i=1, #t do t[i].Id=i end

  return t
end
------------------------------------------------------------------------------

local rc,answer = m_simpleTV.Http.Request(session,{url=inAdr})
if rc~=200 then return end

--debug_in_file(answer .. '\n')

local movie = false
local serial = false

if not string.match( answer, '"season_id"' ) then
  movie = true
 else
  serial = true
end

 local logo='https://wink.rt.ru/assets/fa4f2bd16b18b08e947d77d6b65e397e.svg'
 local poster='https://wink.rt.ru/assets/fa4f2bd16b18b08e947d77d6b65e397e.svg'
 logo = findpattern(answer, 'property="og:image" content="(.-)"',1,29,1)
 poster = findpattern(answer, '"ImageObject","contentUrl":"(.-)"',1,28,1)
 if logo == 'https://s26037.cdn.ngenix.net' then
 logo = findpattern(answer, 'muted="" poster="(.-)"',1,17,1) or poster
 end
 local t={}
 local name, adr, title

if movie then

 local content_id = findpattern(answer, '"content_id":(%d+),',1,13,1)
 if content_id==nil then return end

 title = findpattern(answer, '"Movie","name":"(.-)"',1,16,1)
 if title==nil then title=inAdr end

 t = get_data_table(content_id)
 if t==nil then return end

end

if serial then

 local episode_id = findpattern(answer, '"episode_id":(%d+)%}',1,13,1)
 if episode_id==nil then return end

 title = findpattern(answer, '"episode","(.-)"',1,11,1) or findpattern(answer, '"TVSeries","name":"(.-)"',1,19,1)
 if title==nil then title=inAdr end

 t = get_data_table(episode_id)
 if t==nil then return end

end

if #t==0 then
 local mess = m_simpleTV.Common.multiByteToUTF8('Wink: Ошибка. Адрес не найден',1251)
 m_simpleTV.OSD.ShowMessageT({text=mess,color=ARGB(255,255,0,0),showTime=1000*3,id="channelName"})
 return
end

if m_simpleTV.Control.CurrentTitle_UTF8~=nil then
   m_simpleTV.Control.CurrentTitle_UTF8 = title
end

if m_simpleTV.Control.MainMode == 0 then
	m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = logo, TypeBackColor = 0, UseLogo = 4, Once = 1})
	m_simpleTV.Control.ChangeChannelLogo(logo, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
end

local header = m_simpleTV.Common.multiByteToUTF8('Выберите качество видео',1251)

local ret
local id=1

if #t>1 then

  ret, id = m_simpleTV.OSD.ShowSelect_UTF8('Выберите качество видео',0,t,10000,1+4+8)
  if id==nil then id=1 end

end

m_simpleTV.Control.CurrentAddress = t[id].Address .. '$OPT:http-user-agent=' .. userAgent
----------------------------------------------------------multiaddress
str_poisk = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'-' .. title .. '\')"><img src="simpleTVImage:./work/Channel/Logo/Icons/menuYT.png" height="' .. 36*masshtab ..
			'"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'*' .. title .. '\')"><img src="simpleTVImage:./work/Channel/Logo/Icons/menuKP.png" height="' .. 36*masshtab ..
			'"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. title .. '\')"><img src="simpleTVImage:./work/Channel/Logo/Icons/menuRezka.png" height="' .. 36*masshtab ..
			'"></a>'
name_eng = answer:match('<h4 class="root_r1ru04lg.-">(.-)</h4>')
desc1 = answer:match('<p class="root_r1ru04lg.-">(.-)</p>')
genres = answer:match('data%-test="media%-item%-genres"(.-)</div></div></div></div></div>') or ''
local i_g, genres_str = 1, ''
for w1 in genres:gmatch('<a href=".-".-><.->.-</span></a>') do
genres_adr, genres_name = w1:match('<a href="(.-)".-><.->(.-)</span></a>')
genres_adr = 'https://wink.rt.ru' .. genres_adr
if genres_name and genres_adr then
genres_str = genres_str .. ' 🔸 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres_adr .. '\')" style="color: #EEEEBB; text-decoration: none;">' .. genres_name .. '</a>'
end
i_g = i_g+1
end
persons = answer:match('data%-test="media%-item%-persons"(.-)</div></div></div></div></div></div>') or ''
local i_p, persons_str = 1, ''
for w2 in persons:gmatch('<a href=".-".-><.-><.-></div><h4.->.-</h4><.->.-</span></a>') do
persons_adr, persons_name = w2:match('<a href="(.-)".-><.-><.-></div><h4.->(.-)</h4><.->.-</span></a>')
persons_adr = 'https://wink.rt.ru/search?query=' .. persons_name
if persons_name and persons_adr then
persons_str = persons_str .. ' 🔹 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/search?query=' .. m_simpleTV.Common.toPercentEncoding(persons_name) .. '\')" style="color: #BBBBEE; text-decoration: none;">' .. persons_name .. '</a>'
end
i_p = i_p+1
end
desc2 = genres_str .. '</h5><h5>' .. persons_str
country = answer:match('<span class="root_r1ru04lg value_vzun33j.-">(.-)</span>') or ''
desc = findpattern(answer, ',"description":"(.-)"',1,16,1)

local pars, j, kj, desc_plus = {}, 1, 1, ''
					for media in answer:gmatch('<a data%-type="media_item"(.-)</a>') do
					pars[j] = {}
					pars[j].adr = media:match('href="(.-)"')
					pars[j].adr = 'https://wink.rt.ru' .. pars[j].adr
					pars[j].rating = media:match('<div class="ratings_r1x6jaa5">(.-)</div>')
					pars[j].rating = tonumber(pars[j].rating)
					if not pars[j].rating or pars[j].rating == '' then pars[j].rating = 0 end
					pars[j].name1 = media:match('<h4 class="root_r1ru04lg.-">(.-)</h4>')
					pars[j].poster = answer:match('"' .. pars[j].name1:gsub('%.', '%%.'):gsub('%-', '%%-'):gsub('%+', '%%+'):gsub('%:', '%%:'):gsub('%(', '%%('):gsub('%)', '%%)'):gsub('%?', '%%?'):gsub('%!', '%%!'):gsub('&amp;', '%%&'):gsub('&#x27;', '%\'') .. '".-"(/sdp/.-.jpg)"') or 'https://wink.rt.ru/assets/fa4f2bd16b18b08e947d77d6b65e397e.svg'
					if pars[j].poster ~= 'https://wink.rt.ru/assets/fa4f2bd16b18b08e947d77d6b65e397e.svg' then pars[j].poster = 'https://s26037.cdn.ngenix.net/' .. pars[j].poster end
					desc_plus = desc_plus .. '<table style="float: left;font-size: 22px;color: #7FFFD4; text-decoration: none;" border="0"><tr><td rowspan="2" width="3"><img src="simpleTVImage:./luaScr/user/westSide/icons/pixel.png" height="420" width="1"></td><td width="236"><a href="simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. pars[j].adr .. '\')"><img src="' .. pars[j].poster .. '" height="342" width="236"></a></td></tr><tr><td  width="236" align="center">' .. west_side_substr(pars[j].name1) .. '</td></tr></table>'
					j = j + 1
					end


		local tm = {}
		tm[1] = {}
		tm[1].Id = 1
		tm[1].Name = title
		tm[1].InfoPanelTitle = desc1
		tm[1].InfoPanelName = title
		tm[1].InfoPanelShowTime = 60000
		tm[1].InfoPanelLogo = logo
		tm[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background2 .. '>' .. portal1_str .. '<table width="100\%"><tr><td style="padding: 0px 5px 5px;"><img src="' .. poster ..
		'" width="' .. masshtab*240 .. '"></td><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><h3><font color=#00FA9A>' .. title .. '</font></h3><h3>' .. str_poisk ..
		'</h3><h5><font color=#BBBBBB>' .. name_eng .. '</font></h5><h4>' .. country .. '</h4><h5>' .. desc2 .. '</h5></td></tr></table><table width="100\%"><tr><td style="padding: 0px 5px 5px;"><h5>' .. desc ..
		'</h5></td></tr></table><hr>' .. desc_plus .. '</body></html>'
		tm[1].InfoPanelDesc = tm[1].InfoPanelDesc:gsub('"', '\"')
		tm[1].InfoPanelTitle = tm[1].InfoPanelTitle:gsub('"', '%%22')

--wafee
 local t = {}
 t.message = tm[1].InfoPanelDesc
 t.richTextMode = true
 t.header = tm[1].InfoPanelTitle
 t.showTime = 1000*60
 t.once = true
 t.textAlignment = 1
 t.windowAlignment = 2
 t.windowMaxSizeH = 1
 t.windowMaxSizeV = 1

 if m_simpleTV.User.westSide.PortalTable==nil then
   m_simpleTV.User.westSide.PortalTable=t
 end

-------------------------------------------------
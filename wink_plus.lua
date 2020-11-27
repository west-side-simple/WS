--script for wink.rt.ru (17/11/20) - portal version
-- авторы west_side, wafee
--примеры адресов для запуска
--https://wink.rt.ru/media_items?category_id=17&vod_genres=49253936
--https://wink.rt.ru/search?query=%D0%A2%D0%BE%D0%BC%20%D0%9A%D1%80%D1%83%D0%B7
--https://wink.rt.ru/collections/118?category_id=17
--https://wink.rt.ru/movies
------------------------------------------------------------------------------

if m_simpleTV.Control.ChangeAddress_UTF8 ~= 'No' then return end

local inAdr =  m_simpleTV.Control.CurrentAddress_UTF8
if inAdr==nil then return end

if not string.match( inAdr, '^https://wink%.rt%.ru/media_items?.+' )
and not string.match( inAdr, '^https://wink%.rt%.ru/search?.+' )
and not string.match( inAdr, '^https://wink%.rt%.ru/collections/.+' )
and not string.match( inAdr, '^https://wink%.rt%.ru/movies$' )
and not string.match( inAdr, '^https://wink%.rt%.ru/series$' )
and not string.match( inAdr, '^https://wink%.rt%.ru/kids$' )
and not string.match( inAdr, '^https://wink%.rt%.ru/sport$' )
and not string.match( inAdr, '^https://wink%.rt%.ru/333$' )
then return end

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
	wink_str = '<table style="font-size: 32px;" width="100%"><tr><td style="padding: 10px 10px 0px; vertical-align: middle;"><center><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/movies\')"><img src="https://s26037.cdn.ngenix.net/images/bqo1n35oldao2j46lphg.png" height="' .. 60*masshtab ..
	'" align="top"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/series\')"><img src="https://s26037.cdn.ngenix.net/images/bqo1qotoldao2j46lpl0.png" height="' .. 60*masshtab ..
	'" align="top"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/kids\')"><img src="https://s26037.cdn.ngenix.net/images/bqkmtddoldao2j46lpeg.png" height="' .. 60*masshtab ..
	'" align="top"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/sport\')"><img src="https://s26037.cdn.ngenix.net/images/bpci8htoldao95074c3g.png" height="' .. 60*masshtab ..
	'" align="top"></a><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://wink.rt.ru/333\')"><img src="https://s26037.cdn.ngenix.net/images/bpcika5oldao95074c4g.png" height="' .. 60*masshtab ..
	'" align="top"></a></td></tr></table><hr>'

---------------------------------------------------------------------------
m_simpleTV.Control.ChangeAddress_UTF8='Yes'
m_simpleTV.Control.CurrentAddress_UTF8 = 'error'
if inAdr:match('https://wink%.rt%.ru/search?') then
inAdr = 'https://wink.rt.ru/search?' .. m_simpleTV.Common.fromPercentEncoding(inAdr:gsub('https://wink%.rt%.ru/search%?', ''))
end

--debug_in_file(inAdr .. '\n')

local userAgent = "okhttp/3.14.4"
local session =  m_simpleTV.Http.New(userAgent, nil, false)
if session == nil then return end

local rc,answer = m_simpleTV.Http.Request(session,{url=inAdr})
if rc~=200 then return end

local logo = './luaScr/user/westSide/icons/Search_Wink.jpg'
if not inAdr:match('%?query=') and not inAdr:match('movies') and not inAdr:match('series') and not inAdr:match('kids') and not inAdr:match('sport') then
logo = answer:match('"(/sdp/nc%-snapshot.-%.jpg)"') or answer:match('"(/sdp/nc%-poster.-%.jpg)"')
logo = 'https://s26037.cdn.ngenix.net' .. logo
end
title = answer:match('<title data%-rh=.->(.-)<')
title = title:gsub(' смотреть онлайн в хорошем качестве 1080p.-$', ''):gsub(' смотреть онлайн на Wink в хорошем качестве 1080p.-$', ''):gsub(' в хорошем качестве онлайн 1080p.-$', ''):gsub('Wink %– ТВ%-каналы, фильмы и сериалы смотреть в хорошем качестве.-$', 'Wink')
title_zapros = answer:match('"%?query=(.-)"')
if title_zapros then
title_zapros = m_simpleTV.Common.fromPercentEncoding(title_zapros)
title = title .. ' | ' .. title_zapros
end
local pars, j, kj, desc = {}, 1, 1, ''
					for media in answer:gmatch('<a data%-type="media_item"(.-)</a>') do
					pars[j] = {}
					pars[j].adr = media:match('href="(.-)"')
					pars[j].adr = 'https://wink.rt.ru' .. pars[j].adr
					pars[j].name1 = media:match('<h4 class="root_r1ru04lg.-">(.-)</h4>')
					pars[j].poster = answer:match('"' .. pars[j].name1:gsub('%.', '%%.'):gsub('%-', '%%-'):gsub('%+', '%%+'):gsub('%:', '%%:'):gsub('%(', '%%('):gsub('%)', '%%)'):gsub('%?', '%%?'):gsub('%!', '%%!'):gsub('&amp;', '%%&'):gsub('&#x27;', '%\'') .. '".-"(/sdp/.-.jpg)"') or 'https://wink.rt.ru/assets/fa4f2bd16b18b08e947d77d6b65e397e.svg'
					if pars[j].poster ~= 'https://wink.rt.ru/assets/fa4f2bd16b18b08e947d77d6b65e397e.svg' then pars[j].poster = 'https://s26037.cdn.ngenix.net/' .. pars[j].poster end
					desc = desc .. '<table style="float: left;font-size: 22px;color: #7FFFD4; text-decoration: none;" border="0"><tr><td rowspan="2" width="3"><img src="simpleTVImage:./luaScr/user/westSide/icons/pixel.png" height="420" width="1"></td><td width="236"><a href="simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. pars[j].adr .. '\')"><img src="' .. pars[j].poster .. '" height="342" width="236"></a></td></tr><tr><td  width="236" align="center">' .. west_side_substr(pars[j].name1) .. '</td></tr></table>'
					j = j + 1
					end

local parstv, jtv, desctv = {}, 1, ''
					for mediatv in answer:gmatch('<a (href="/tv.-)</a>') do
					parstv[jtv] = {}
					parstv[jtv].adr = mediatv:match('href="(.-)"')
					parstv[jtv].adr = 'https://wink.rt.ru' .. parstv[jtv].adr
					parstv[jtv].name1 = mediatv:match('<img alt="(.-)"')
					parstv[jtv].poster = mediatv:match('src="(.-)"')
					parstv[jtv].logo = mediatv:match('src=".-".-src="(.-)"')
					if parstv[jtv].adr and parstv[jtv].name1 and parstv[jtv].poster and parstv[jtv].logo then
					desctv = desctv .. '<table style="float: left;font-size: 22px;color: #7FFFD4; text-decoration: none;" border="0"><tr><td rowspan="2" width="3"><img src="simpleTVImage:./luaScr/user/westSide/icons/pixel.png" height="236" width="1"></td><td width="236"><a href="simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. parstv[jtv].adr .. '\')"><img src="' .. parstv[jtv].poster .. '" height="133" width="236"></a></td></tr><tr><td  width="236" align="center"><img src="' .. parstv[jtv].logo .. '" height="40" width="60">' .. west_side_substr(parstv[jtv].name1) .. '</td></tr></table>'

					jtv = jtv + 1
					end
					end

					local pars1, j1, kj1, desc1 = {}, 1, 1, ''
					answer1 = answer:match('"media_item",.-$')
					desc1_name = 'Новинки'
					if answer1 then
					for media1 in answer1:gmatch('"/images/.-%.jpg",%{"id":%d+,') do
					pars1[j1] = {}
					pars1[j1].poster = media1:match('"(/images/.-.jpg)",')
					pars1[j1].poster = 'https://s26037.cdn.ngenix.net' .. pars1[j1].poster
					pars1[j1].adr = media1:match('"id":(%d+),')
					pars1[j1].name1, pars1[j1].name2 = answer:match('data%-type="banner" href="/media_items/' .. pars1[j1].adr .. '.-<h2 class="root_r1ru04lg.-">(.-)</h2>(.-)</a>')
					if pars1[j1].name2 and pars1[j1].name2:match('<p class="root_r1ru04lg.-">.-</p>')
						then pars1[j1].name2 = pars1[j1].name2:match('<p class="root_r1ru04lg.-">(.-)</p>')
						else pars1[j1].name2 = ''
					end
					if not pars1[j1].name1 then pars1[j1].name1 = '' end
					if not pars1[j1].name2 then pars1[j1].name2 = '' end
					pars1[j1].adr = 'https://wink.rt.ru/media_items/' .. pars1[j1].adr
					if pars1[j1].name1 ~= '' then
					if kj1 == 3 then
						desc1 = desc1 .. '</tr><tr>' kj1 = 1
					end
					desc1 = desc1 .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*500 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. pars1[j1].adr ..
					'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. pars1[j1].poster .. '" width = "' .. 500*masshtab ..
					'"><h5><center><font color=#00FA9A>' .. pars1[j1].name1 .. '</font></h5><h5><font color=#BBBBBB>' .. pars1[j1].name2 .. '</font></h5></a></td>'
					kj1 = kj1 + 1
					end
					j1 = j1 + 1
					end
					end

					local pars2, j2, kj2, desc2 = {}, 1, 1, ''
					answer2 = answer:match('">Подборки</h3>.-$')
					if answer2 then
					for media2 in answer2:gmatch('data%-type="banner".-href=".-".-src=".-".-srcSet=".-".-<div class="root_r1ru04lg age_level.-">.-</div>.-<h4 class="root_r1ru04lg.-">.-</h4><div class="root_r1ru04lg subtitle.-">.-</div></div></a>') do
					pars2[j2] = {}
					pars2[j2].poster = media2:match('src="(.-)"')
					pars2[j2].adr = media2:match('href="(.-)"')
					pars2[j2].adr = 'https://wink.rt.ru' .. pars2[j2].adr
					pars2[j2].name1, pars2[j2].name2, pars2[j2].name3 = media2:match('data%-type="banner".-href=".-".-src=".-".-srcSet=".-".-<div class="root_r1ru04lg age_level.-">(.-)</div>.-<h4 class="root_r1ru04lg.-">(.-)</h4><div class="root_r1ru04lg subtitle.-">(.-)</div></div></a>')
					if not pars2[j2].name1 then pars2[j2].name1 = '' end
					if not pars2[j2].name2 then pars2[j2].name2 = '' end
					if not pars2[j2].name3 then pars2[j2].name3 = '' end
					if kj2 == 4 then
						desc2 = desc2 .. '</tr><tr>' kj2 = 1
					end
					desc2 = desc2 .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*333 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. pars2[j2].adr ..
					'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. pars2[j2].poster .. '" width = "' .. 300*masshtab ..
					'"><h5><center><font color=#00FA9A>' .. pars2[j2].name2 .. ' • ' .. pars2[j2].name1 .. '</font></h5><h5><font color=#BBBBBB>' .. pars2[j2].name3 .. '</font></h5></a></td>'
					kj2 = kj2 + 1
					j2 = j2 + 1
					end
					elseif not answer2 and inAdr:match('series') then
						local path1 = './luaScr/user/TVSources/m3u/out_Wink Media.m3u'
						local file1 = io.open('./luaScr/user/TVSources/m3u/out_Wink Media.m3u', 'r')
						if not file1 then
						m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path1) return end
						local answer_pls1 = file1:read('*a')
						file1:close()
						local i, my_pls1 = 1, {}
						local t_pls1, i_pls1, k_pls1 = {}, 1, 1
						for tab_pls1 in answer_pls1:gmatch('tvg%-logo=".-".-https://wink%.rt%.ru/collections/%d+%?category_id=17') do
							t_pls1[i_pls1] = {}
							t_pls1[i_pls1].logo_pls1, t_pls1[i_pls1].name_pls1, t_pls1[i_pls1].adr_pls1 = tab_pls1:match('tvg%-logo="(.-)".-,(.-)https://wink%.rt%.ru/collections/(%d+)%?category_id=17')
							if tonumber(t_pls1[i_pls1].adr_pls1) == 26
							or tonumber(t_pls1[i_pls1].adr_pls1) == 25
							or tonumber(t_pls1[i_pls1].adr_pls1) == 384
							or tonumber(t_pls1[i_pls1].adr_pls1) == 361
							or tonumber(t_pls1[i_pls1].adr_pls1) == 357
							or tonumber(t_pls1[i_pls1].adr_pls1) == 522
							or tonumber(t_pls1[i_pls1].adr_pls1) == 358
							or tonumber(t_pls1[i_pls1].adr_pls1) == 501
							or tonumber(t_pls1[i_pls1].adr_pls1) == 200
							or tonumber(t_pls1[i_pls1].adr_pls1) == 931
							or tonumber(t_pls1[i_pls1].adr_pls1) == 30
							or tonumber(t_pls1[i_pls1].adr_pls1) == 105
							then
							if k_pls1 == 4 then
								desc2 = desc2 .. '</tr><tr>' k_pls1 = 1
							end
							t_pls1[i_pls1].adr_pls1 = 'https://wink.rt.ru/collections/' .. t_pls1[i_pls1].adr_pls1 .. '?category_id=17'
							desc2 = desc2 .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*333 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls1[i_pls1].adr_pls1 ..
							'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. t_pls1[i_pls1].logo_pls1 .. '" width = "' .. 300*masshtab .. '"><h5><font color=#BBBBBB>' .. t_pls1[i_pls1].name_pls1 .. '</font></h5></a></td>'
							k_pls1 = k_pls1 + 1
							end
							i_pls1 = i_pls1 + 1
						end
					elseif not answer2 and inAdr:match('kids') then
						local path1 = './luaScr/user/TVSources/m3u/out_Wink Media.m3u'
						local file1 = io.open('./luaScr/user/TVSources/m3u/out_Wink Media.m3u', 'r')
						if not file1 then
						m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path1) return end
						local answer_pls1 = file1:read('*a')
						file1:close()
						local i, my_pls1 = 1, {}
						local t_pls1, i_pls1, k_pls1 = {}, 1, 1
						for tab_pls1 in answer_pls1:gmatch('tvg%-logo=".-".-https://wink%.rt%.ru/collections/%d+%?category_id=17') do
							t_pls1[i_pls1] = {}
							t_pls1[i_pls1].logo_pls1, t_pls1[i_pls1].name_pls1, t_pls1[i_pls1].adr_pls1 = tab_pls1:match('tvg%-logo="(.-)".-,(.-)https://wink%.rt%.ru/collections/(%d+)%?category_id=17')
							if tonumber(t_pls1[i_pls1].adr_pls1) == 18
							or tonumber(t_pls1[i_pls1].adr_pls1) == 17
							or tonumber(t_pls1[i_pls1].adr_pls1) == 744
							or tonumber(t_pls1[i_pls1].adr_pls1) == 705
							or tonumber(t_pls1[i_pls1].adr_pls1) == 516
							or tonumber(t_pls1[i_pls1].adr_pls1) == 437
							or tonumber(t_pls1[i_pls1].adr_pls1) == 217
							or tonumber(t_pls1[i_pls1].adr_pls1) == 879
							or tonumber(t_pls1[i_pls1].adr_pls1) == 765
							or tonumber(t_pls1[i_pls1].adr_pls1) == 507
							or tonumber(t_pls1[i_pls1].adr_pls1) == 29
							or tonumber(t_pls1[i_pls1].adr_pls1) == 267
							or tonumber(t_pls1[i_pls1].adr_pls1) == 100
							or tonumber(t_pls1[i_pls1].adr_pls1) == 212
							or tonumber(t_pls1[i_pls1].adr_pls1) == 506
							then
							if k_pls1 == 4 then
								desc2 = desc2 .. '</tr><tr>' k_pls1 = 1
							end
							t_pls1[i_pls1].adr_pls1 = 'https://wink.rt.ru/collections/' .. t_pls1[i_pls1].adr_pls1 .. '?category_id=17'
							desc2 = desc2 .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*333 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls1[i_pls1].adr_pls1 ..
							'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. t_pls1[i_pls1].logo_pls1 .. '" width = "' .. 300*masshtab .. '"><h5><font color=#BBBBBB>' .. t_pls1[i_pls1].name_pls1 .. '</font></h5></a></td>'
							k_pls1 = k_pls1 + 1
							end
							i_pls1 = i_pls1 + 1
						end
					elseif not answer2 and inAdr:match('333') then
					title = title .. ' for FRIENDS'
						local path1 = './luaScr/user/TVSources/m3u/out_Wink Media.m3u'
						local file1 = io.open('./luaScr/user/TVSources/m3u/out_Wink Media.m3u', 'r')
						if not file1 then
						m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path1) return end
						local answer_pls1 = file1:read('*a')
						file1:close()
						local i, my_pls1 = 1, {}
						local t_pls1, i_pls1, k_pls1 = {}, 1, 1
						for tab_pls1 in answer_pls1:gmatch('tvg%-logo=".-".-https://wink%.rt%.ru/collections/%d+%?category_id=17') do
							t_pls1[i_pls1] = {}
							t_pls1[i_pls1].logo_pls1, t_pls1[i_pls1].name_pls1, t_pls1[i_pls1].adr_pls1 = tab_pls1:match('tvg%-logo="(.-)".-,(.-)https://wink%.rt%.ru/collections/(%d+)%?category_id=17')
							if tonumber(t_pls1[i_pls1].adr_pls1) == 21
							or tonumber(t_pls1[i_pls1].adr_pls1) == 23
							or tonumber(t_pls1[i_pls1].adr_pls1) == 24
							or tonumber(t_pls1[i_pls1].adr_pls1) == 81
							or tonumber(t_pls1[i_pls1].adr_pls1) == 83
							or tonumber(t_pls1[i_pls1].adr_pls1) == 512
							or tonumber(t_pls1[i_pls1].adr_pls1) == 580
							or tonumber(t_pls1[i_pls1].adr_pls1) == 583
							or tonumber(t_pls1[i_pls1].adr_pls1) == 685
							or tonumber(t_pls1[i_pls1].adr_pls1) == 934
							or tonumber(t_pls1[i_pls1].adr_pls1) == 591
							or tonumber(t_pls1[i_pls1].adr_pls1) == 13
							or tonumber(t_pls1[i_pls1].adr_pls1) == 14							
							or tonumber(t_pls1[i_pls1].adr_pls1) == 18
							or tonumber(t_pls1[i_pls1].adr_pls1) == 748
							then
							if k_pls1 == 4 then
								desc2 = desc2 .. '</tr><tr>' k_pls1 = 1
							end
							t_pls1[i_pls1].adr_pls1 = 'https://wink.rt.ru/collections/' .. t_pls1[i_pls1].adr_pls1 .. '?category_id=17'
							desc2 = desc2 .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*333 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls1[i_pls1].adr_pls1 ..
							'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. t_pls1[i_pls1].logo_pls1 .. '" width = "' .. 300*masshtab .. '"><h5><font color=#BBBBBB>' .. t_pls1[i_pls1].name_pls1 .. '</font></h5></a></td>'
							k_pls1 = k_pls1 + 1
							end
							i_pls1 = i_pls1 + 1
						end	
						local path2 = './luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u'
						local file2 = io.open('./luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u', 'r')
						if not file2 then
						m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path2) return end
						local answer_pls2 = file2:read('*a')
						file2:close()
						local t_pls2, i_pls2, k_pls2, desc3 = {}, 1, 1, ''
						for tab_pls2 in answer_pls2:gmatch('group%-title=".-".-tvg%-logo=".-".-https://wink%.rt%.ru/tv/%d+') do
						t_pls2[i_pls2] = {}
						t_pls2[i_pls2].logo_pls2, t_pls2[i_pls2].adr_pls2 = tab_pls2:match('tvg%-logo="(.-)".-https://wink%.rt%.ru/tv/(%d+)')
						if tonumber(t_pls2[i_pls2].adr_pls2) == 247
						or tonumber(t_pls2[i_pls2].adr_pls2) == 257
						or tonumber(t_pls2[i_pls2].adr_pls2) == 259
						or tonumber(t_pls2[i_pls2].adr_pls2) == 265
						or tonumber(t_pls2[i_pls2].adr_pls2) == 292
						or tonumber(t_pls2[i_pls2].adr_pls2) == 296
						or tonumber(t_pls2[i_pls2].adr_pls2) == 825
						or tonumber(t_pls2[i_pls2].adr_pls2) == 826
						or tonumber(t_pls2[i_pls2].adr_pls2) == 827
						or tonumber(t_pls2[i_pls2].adr_pls2) == 828
						or tonumber(t_pls2[i_pls2].adr_pls2) == 829
						or tonumber(t_pls2[i_pls2].adr_pls2) == 830
						or tonumber(t_pls2[i_pls2].adr_pls2) == 831
						or tonumber(t_pls2[i_pls2].adr_pls2) == 444
						or tonumber(t_pls2[i_pls2].adr_pls2) == 486
						or tonumber(t_pls2[i_pls2].adr_pls2) == 766
						or tonumber(t_pls2[i_pls2].adr_pls2) == 498
						or tonumber(t_pls2[i_pls2].adr_pls2) == 504
						or tonumber(t_pls2[i_pls2].adr_pls2) == 505
						or tonumber(t_pls2[i_pls2].adr_pls2) == 506
						or tonumber(t_pls2[i_pls2].adr_pls2) == 515
						or tonumber(t_pls2[i_pls2].adr_pls2) == 520
						or tonumber(t_pls2[i_pls2].adr_pls2) == 521
						or tonumber(t_pls2[i_pls2].adr_pls2) == 522
						or tonumber(t_pls2[i_pls2].adr_pls2) == 523
						or tonumber(t_pls2[i_pls2].adr_pls2) == 539
						or tonumber(t_pls2[i_pls2].adr_pls2) == 540
						or tonumber(t_pls2[i_pls2].adr_pls2) == 541
						or tonumber(t_pls2[i_pls2].adr_pls2) == 542
						or tonumber(t_pls2[i_pls2].adr_pls2) == 441						
						then
						t_pls2[i_pls2].adr_pls2 = 'https://wink.rt.ru/tv/' .. t_pls2[i_pls2].adr_pls2
						if k_pls2 == 7 then
							desc3 = desc3 .. '</tr><tr>' k_pls2 = 1
						end
						desc3 = desc3 .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls2[i_pls2].adr_pls2 ..
						'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. t_pls2[i_pls2].logo_pls2 .. '" height = "' .. 90*masshtab .. '" width = "' .. 160*masshtab .. '"></a></td>'
						k_pls2 = k_pls2 + 1
						i_pls2 = i_pls2 + 1
						end
						end
						desc1 = desc1 .. 
						'</td></tr></table><table style="font-size: 40px;" width="100\%"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><hr><center><font color=#4169E1>' .. 'Избранные ТВ каналы' .. 
						'</td></tr></table><table width="100\%">' .. desc3 .. '</tr></table>'
					elseif not answer2 and inAdr:match('sport') then
					title = title .. ' SPORT'					
						desc1_name = 'Спортивные каналы'
						local path1 = './luaScr/user/TVSources/m3u/out_Wink Media.m3u'
						local file1 = io.open('./luaScr/user/TVSources/m3u/out_Wink Media.m3u', 'r')
						if not file1 then
						m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path1) return end
						local answer_pls1 = file1:read('*a')
						file1:close()
						local i, my_pls1 = 1, {}
						local t_pls1, i_pls1, k_pls1 = {}, 1, 1
						for tab_pls1 in answer_pls1:gmatch('tvg%-logo=".-".-https://wink%.rt%.ru/collections/%d+%?category_id=17') do
							t_pls1[i_pls1] = {}
							t_pls1[i_pls1].logo_pls1, t_pls1[i_pls1].name_pls1, t_pls1[i_pls1].adr_pls1 = tab_pls1:match('tvg%-logo="(.-)".-,(.-)https://wink%.rt%.ru/collections/(%d+)%?category_id=17')
							if tonumber(t_pls1[i_pls1].adr_pls1) == 141
							or tonumber(t_pls1[i_pls1].adr_pls1) == 641
							or tonumber(t_pls1[i_pls1].adr_pls1) == 426
							or tonumber(t_pls1[i_pls1].adr_pls1) == 547
							or tonumber(t_pls1[i_pls1].adr_pls1) == 543
							or tonumber(t_pls1[i_pls1].adr_pls1) == 570
							then
							if k_pls1 == 4 then
								desc2 = desc2 .. '</tr><tr>' k_pls1 = 1
							end
							t_pls1[i_pls1].adr_pls1 = 'https://wink.rt.ru/collections/' .. t_pls1[i_pls1].adr_pls1 .. '?category_id=17'
							desc2 = desc2 .. '<td style="padding: 0px 5px 5px; color: #EBEBEB;" width="' .. masshtab*333 .. '"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls1[i_pls1].adr_pls1 ..
							'\')" style="color: #7FFFD4; text-decoration: none;"><center><img src="' .. t_pls1[i_pls1].logo_pls1 .. '" width = "' .. 300*masshtab .. '"><h5><font color=#BBBBBB>' .. t_pls1[i_pls1].name_pls1 .. '</font></h5></a></td>'
							k_pls1 = k_pls1 + 1
							end
							i_pls1 = i_pls1 + 1
						end
						local path2 = './luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u'
						local file2 = io.open('./luaScr/user/TVSources/m3u/out_PORTAL Wink TV.m3u', 'r')
						if not file2 then
						m_simpleTV.OSD.ShowMessage_UTF8('Необходимо добавить файл ' .. path2) return end
						local answer_pls2 = file2:read('*a')
						file2:close()
						local t_pls2, i_pls2, k_pls2, desc3 = {}, 1, 1, ''
						for tab_pls2 in answer_pls2:gmatch('group%-title=".-".-tvg%-logo=".-".-https://wink%.rt%.ru/tv/%d+') do
						t_pls2[i_pls2] = {}
						t_pls2[i_pls2].name_grp2, t_pls2[i_pls2].logo_pls2, t_pls2[i_pls2].adr_pls2 = tab_pls2:match('group%-title="(.-)".-tvg%-logo="(.-)".-(https://wink%.rt%.ru/tv/%d+)')
						if t_pls2[i_pls2].name_grp2:match('Спортивные') then
						if k_pls2 == 7 then
							desc3 = desc3 .. '</tr><tr>' k_pls2 = 1
						end
						desc3 = desc3 .. '<td style="padding: 5px 5px 0px; color: #EBEBEB;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t_pls2[i_pls2].adr_pls2 ..
						'\')" style="color: #7FFFD4; text-decoration: none;"><img src="' .. t_pls2[i_pls2].logo_pls2 .. '" height = "' .. 90*masshtab .. '" width = "' .. 160*masshtab .. '"></a></td>'
						k_pls2 = k_pls2 + 1
						i_pls2 = i_pls2 + 1
						end
						end
						desc1 = desc3
						end

					if inAdr:match('movies') or inAdr:match('series') or inAdr:match('kids') or inAdr:match('sport') or inAdr:match('333')then
					desc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. wink_str .. '<table style="font-size: 40px;" width="100%"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><center><font color=#6495ED>' .. title ..
					'</td></tr></table><table style="font-size: 40px;" width="100%"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><center><font color=#4169E1>' .. desc1_name ..
					'</td></tr></table><table style="font-size: 40px;" width="100%"><tr>' .. desc1 .. '</td></tr></table><hr><table style="font-size: 40px;" width="100%"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><center><font color=#4169E1>' .. 'Подборки' ..
					'</td></tr></table><table style="font-size: 40px;" width="100%"><tr>' .. desc2 .. '</td></tr></table></body></html>'
					else
					desc = '<html><body bgcolor="#434750" ' .. background1 .. '>' .. portal_str .. '<table style="font-size: 40px;" width="100%"><tr><td style="padding: 0px 5px 5px; color: #EBEBEB; vertical-align: middle;"><center><font color=#6495ED>' .. title ..
					'</td></tr></table>' .. desc .. '<p>' .. desctv .. '</body></html>'
					end
--debug_in_file(answer .. '\n')

local poster='./luaScr/user/westSide/icons/Channels.jpg'

if m_simpleTV.Control.CurrentTitle_UTF8~=nil then
   m_simpleTV.Control.CurrentTitle_UTF8 = title
end

if m_simpleTV.Control.MainMode == 0 then
	m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = logo, TypeBackColor = 0, UseLogo = 4, Once = 1})
	m_simpleTV.Control.ChangeChannelLogo(poster, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
end
local retAdr = background_chanel
m_simpleTV.Control.CurrentAddress_UTF8 = retAdr
----------------------------------------------------------multiaddress

		local tm = {}
		tm[1] = {}
		tm[1].Id = 1
		tm[1].Name = title
		tm[1].Address = background_chanel
		tm[1].InfoPanelTitle = title
		tm[1].InfoPanelName = title
		tm[1].InfoPanelShowTime = 60000
		tm[1].InfoPanelLogo = poster
		tm[1].InfoPanelDesc = desc
		tm[1].InfoPanelDesc = tm[1].InfoPanelDesc:gsub('"', '\"')
		tm[1].InfoPanelTitle = tm[1].InfoPanelTitle:gsub('"', '%%22')

--wafee
 local t = {}
 t.message = tm[1].InfoPanelDesc
 t.richTextMode = true
 t.header = tm[1].InfoPanelTitle
 t.showTime = 1000*60
 t.once = true
 --t.textAlignment = 1
 t.windowAlignment = 2
 t.windowMaxSizeH = 1
 t.windowMaxSizeV = 1

 if m_simpleTV.User.westSide.PortalTable==nil then
   m_simpleTV.User.westSide.PortalTable=t --кешируем данные в юзер таблицу
 end

 show_portal_window() -- hotkey 'I'

-------------------------------------------------
-- видеоскрипт для сайта https://rips.club (27/09/20) v.3
-- ветка на bugtracker http://iptv.gen12.net/bugtracker/view.php?id=1596
-- авторы nexterr, west_side
-- открывает подобные ссылки:
-- https://rips.club/video-2047/
-- а так же все ссылки с сайта плюс поиск
		if not m_simpleTV.Control.CurrentAddress:match('^https?://rips.club') then return end
		local url1 = 'https://rips.club'
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
		local poster_hevc = './luaScr/user/westSide/icons/search.jpg'
		local titul_hevc = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/h265.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_rezka_tor = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rezka.cc\/\')"><img src="https://rezka.cc/apple-touch-icon.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_lostfilm = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.lostfilm.tv/new\/\')"><img src="https://www.lostfilm.tv/favicon.ico" height="' .. 36*masshtab .. '" align="top"></a>'
		local titul_yt = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://www.youtube.com/feed/channels\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/menuYT.png" height="' .. 36*masshtab .. '" align="top"></a>'
		local search_home = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club/search/?part=0&year=&cat=0&standard=0&bit=0&order=0&search=\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/home.jpg" width = "' .. 166*masshtab .. '"></a>'
		local search_movies = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club/search/?part=1&year=&cat=0&standard=0&bit=0&order=0&search=\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/movies.jpg" width = "' .. 166*masshtab .. '"></a>'
		local search_tvshows = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club/search/?part=2&year=&cat=0&standard=0&bit=0&order=0&search=\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/tvshows.jpg" width = "' .. 166*masshtab .. '"></a>'
		local search_music = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club/search/?part=3&year=&cat=0&standard=0&bit=0&order=0&search=\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/music.jpg" width = "' .. 166*masshtab .. '"></a>'
		local search_kids = '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'https://rips.club/search/?part=0&year=&cat=15&standard=0&bit=0&order=0&search=\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/kids.jpg" width = "' .. 166*masshtab .. '"></a>'
		local start_search = '<tr><td style="padding: 10px 10px 10px;">' .. search_home .. '</td>' ..
		'<td style="padding: 10px 10px 10px;">' .. search_movies .. '</td>' ..
		'<td style="padding: 10px 10px 10px;">' .. search_tvshows .. '</td>' ..
		'<td style="padding: 10px 10px 10px;">' .. search_music .. '</td>' ..
		'<td style="padding: 10px 10px 10px;">' .. search_kids .. '</td></tr></table>'
	dataEN = os.date ("%a %d %b %Y %H:%M")
	dataRU = dataEN:gsub('Sun', 'Вс'):gsub('Mon', 'Пн'):gsub('Tue', 'Вт'):gsub('Wed', 'Ср'):gsub('Thu', 'Чт'):gsub('Fri', 'Пт'):gsub('Sat', 'Сб')
	dataRU = dataRU:gsub('Jan', 'Янв'):gsub('Feb', 'Фев'):gsub('Mar', 'Мар'):gsub('Apr', 'Апр'):gsub('May', 'Май'):gsub('Jun', 'Июн'):gsub('Jul', 'Июл'):gsub('Aug', 'Авг'):gsub('Sep', 'Сен'):gsub('Oct', 'Окт'):gsub('Nov', 'Ноя'):gsub('Dec', 'Дек')
	if m_simpleTV.Interface.GetLanguage() == 'ru' then data = dataRU else data = dataEn end
	m_simpleTV.OSD.ShowMessageT({text = '', showTime = 5000, id = 'channelName'})
	local inAdr = m_simpleTV.Control.CurrentAddress
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = './luaScr/user/westSide/icons/home.jpg', TypeBackColor = 0, UseLogo = 0, Once = 1})
	end
	local function showError(str)
		m_simpleTV.OSD.ShowMessageT({text = 'RIPS-CLUB ошибка: ' .. str, showTime = 5000, color = 0xffff1000, id = 'channelName'})
	end
	m_simpleTV.Control.ChangeAddress = 'Yes'
	m_simpleTV.Control.CurrentAddress = ''
	local session = m_simpleTV.Http.New('Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML,like Gecko) Chrome/81.0.3809.87 Safari/537.36')
		if not session then
			showError('1')
		 return
		end
	m_simpleTV.Http.SetTimeout(session, 12000)
	local rc, answer = m_simpleTV.Http.Request(session, {url = inAdr})
		if rc ~= 200 then
			showError('2')
--			m_simpleTV.Http.Close(session)
		 return
		end
	answer = answer:gsub('\n', ' ')
	local retAdr = answer:match('[^"\']+/torrent%.php[^"\']+')
		if not retAdr then retAdr = background_chanel
--			showError('3')
--		 return
		end
	if inAdr:match('part=0') then poster_hevc = './luaScr/user/westSide/icons/home.jpg' end
	if inAdr:match('part=1') then poster_hevc = './luaScr/user/westSide/icons/movies.jpg' end
	if inAdr:match('part=2') then poster_hevc = './luaScr/user/westSide/icons/tvshows.jpg' end
	if inAdr:match('part=3') then poster_hevc = './luaScr/user/westSide/icons/music.jpg' end
	if inAdr:match('cat=15') then poster_hevc = './luaScr/user/westSide/icons/kids.jpg' end
	local poster = answer:match('"og:image" content="([^"]+)') or poster_hevc
	poster1 = poster
	if m_simpleTV.Control.MainMode == 0 then
	if poster == poster_hevc or poster == 'https://rips.club/img/header.jpg'then
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = poster_hevc, TypeBackColor = 0, UseLogo = 3, Once = 1})
	else
		m_simpleTV.Interface.SetBackground({BackColor = 0, PictFileName = poster1, TypeBackColor = 0, UseLogo = 3, Once = 1})
	end
	end
		if not m_simpleTV.User then
		m_simpleTV.User = {}
	end
	if not m_simpleTV.User.hevcClub then
		m_simpleTV.User.hevcClub = {}
	end
	m_simpleTV.User.hevcClub.DelayedAddress = nil
	function OnMultiAddressOk_hevcClub(Object, id)
		if id == 0 then
			OnMultiAddressCancel_hevcClub(Object)
		else
			m_simpleTV.User.hevcClub.DelayedAddress = nil
		end
	end
	function OnMultiAddressCancel_hevcClub(Object)
		if m_simpleTV.User.hevcClub.DelayedAddress then
			local state = m_simpleTV.Control.GetState()
			if state == 0 then
				m_simpleTV.Control.SetNewAddress(m_simpleTV.User.hevcClub.DelayedAddress)
			end
			m_simpleTV.User.hevcClub.DelayedAddress = nil
		end
		m_simpleTV.Control.ExecuteAction(36, 0)
	end
	if retAdr ~= background_chanel then
	local host = inAdr:match('^https?://.-/')
	retAdr = retAdr:gsub('^/', host)
	local rc, torFile = m_simpleTV.Http.Request(session, {url = retAdr, writeinfile = true})
	m_simpleTV.Http.Close(session)
		if rc ~= 200 then
			showError('4')
		 return
		end
	retAdr = 'torrent://' .. torFile
	--------ссылки на жанры
				genres1_adr = 'https://rips.club/search/?page=1&cat=1'
				genres2_adr = 'https://rips.club/search/?page=1&cat=2'
				genres3_adr = 'https://rips.club/search/?page=1&cat=3'
				genres4_adr = 'https://rips.club/search/?page=1&cat=4'
				genres5_adr = 'https://rips.club/search/?page=1&cat=5'
				genres6_adr = 'https://rips.club/search/?page=1&cat=6'
				genres7_adr = 'https://rips.club/search/?page=1&cat=7'
				genres8_adr = 'https://rips.club/search/?page=1&cat=8'
				genres9_adr = 'https://rips.club/search/?page=1&cat=9'
				genres10_adr = 'https://rips.club/search/?page=1&cat=10'
				genres11_adr = 'https://rips.club/search/?page=1&cat=11'
				genres12_adr = 'https://rips.club/search/?page=1&cat=12'
				genres13_adr = 'https://rips.club/search/?page=1&cat=13'
				genres14_adr = 'https://rips.club/search/?page=1&cat=14'
				genres15_adr = 'https://rips.club/search/?page=1&cat=15'
				genres16_adr = 'https://rips.club/search/?page=1&cat=16'
				genres17_adr = 'https://rips.club/search/?page=1&cat=17'
				genres18_adr = 'https://rips.club/search/?page=1&cat=18'
				genres19_adr = 'https://rips.club/search/?page=1&cat=19'
				genres20_adr = 'https://rips.club/search/?page=1&cat=20'
				genres21_adr = 'https://rips.club/search/?page=1&cat=21'
				genres22_adr = 'https://rips.club/search/?page=1&cat=22'
				genres23_adr = 'https://rips.club/search/?page=1&cat=23'
				genres24_adr = 'https://rips.club/search/?page=1&cat=24'
				genres25_adr = 'https://rips.club/search/?page=1&cat=25'
				genres26_adr = 'https://rips.club/search/?page=1&cat=26'
				genres27_adr = 'https://rips.club/search/?page=1&cat=27'
-----------------
	local title = answer:match('"og:title" content="([^"]+)') or 'RIPS-CLUB'
	title = title:gsub(' %[HEVC] .-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
	local t = {}
	number_files = answer:match('<summary>Файлы: (.-)</summary>')
	if number_files == '1' then
--------------------не сериал
	local year, country, genres, director, actors, sostav, ses, name, titledesc, desc, desc1, topdesc
				year = answer:match('<b>Год:</b> (.-)<br>') or ''
				country = answer:match('<b>Страна:</b> (.-)<br>') or ''
				genres = answer:match('<b>Жанр:</b> (.-)<br>') or ''
				genres_str = genres:gsub(',', '')
				genres_str = genres_str:gsub('Биография', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres1_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Биография</a>')
				genres_str = genres_str:gsub('Боевик', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres2_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Боевик</a>')
				genres_str = genres_str:gsub('Вестерн', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres3_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Вестерн</a>')
				genres_str = genres_str:gsub('Военный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres4_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Военный</a>')
				genres_str = genres_str:gsub('Детектив', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres5_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детектив</a>')
				genres_str = genres_str:gsub('Детский', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres6_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детский</a>')
				genres_str = genres_str:gsub('Документальный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres7_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Документальный</a>')
				genres_str = genres_str:gsub('История', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres9_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">История</a>')
				genres_str = genres_str:gsub('Катастрофа', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres26_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Катастрофа</a>')
				genres_str = genres_str:gsub('Комедия', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres10_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Комедия</a>')
				genres_str = genres_str:gsub('Короткометражка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres11_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Короткометражка</a>')
				genres_str = genres_str:gsub('Криминал', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres12_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Криминал</a>')
				genres_str = genres_str:gsub('Мистика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres27_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мистика</a>')
				genres_str = genres_str:gsub('Музыка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres14_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Музыка</a>')
				genres_str = genres_str:gsub('Мультфильм', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres15_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мультфильм</a>')
				genres_str = genres_str:gsub('Мюзикл', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres16_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мюзикл</a>')
				genres_str = genres_str:gsub('Приключения', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres17_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Приключения</a>')
				genres_str = genres_str:gsub('Семейный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres18_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Семейный</a>')
				genres_str = genres_str:gsub('Спорт', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres19_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Спорт</a>')
				genres_str = genres_str:gsub('ТВ', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres20_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">ТВ</a>')
				genres_str = genres_str:gsub('Ток%-шоу', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres21_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ток-шоу</a>')
				genres_str = genres_str:gsub('Триллер', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres22_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Триллер</a>')
				genres_str = genres_str:gsub('Ужасы', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres23_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ужасы</a>')
				genres_str = genres_str:gsub('Фантастика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres24_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фантастика</a>')
				genres_str = genres_str:gsub('Фэнтези', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres25_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фэнтези</a>')
				genres_str = genres_str:gsub('Мелодрама', 'genres_tmp')
				genres_str = genres_str:gsub('Драма', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres8_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Драма</a>')
				genres_str = genres_str:gsub('genres_tmp', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres13_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мелодрама</a>')
				studia = answer:match('<b>Студия:</b> (.-)<br>') or ''
				alltime = answer:match('<b>Продолжительность:</b> (.-)<br>') or ''
				director = answer:match('<b>Режиссер:</b> (.-)<br>') or ''
				actors = answer:match('<b>В ролях:</b> (.-)<br>') or ''
				sostav = ''
				if actors == '' then sostav = answer:match('<b>Состав:</b><br>(.-)<br>') end
				ses = title:match('%)(.-)BDRip') or ''
				if not ses:match('сезон') then ses = ''
				else ses = '. ' .. ses:gsub('%[', ''):gsub('%]', '') end
				name = title:gsub(' %(.-$', '')
				name_rus = name:gsub(' %/.-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_eng = name:gsub('.-%/ ', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_rus = name_rus .. ses
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="' .. m_simpleTV.MainScriptDir .. 'user/westSide/country/' .. country_ID .. '.png" height="' .. 36*masshtab .. '" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if country and country:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Южная Корея') or country and country:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('США') or country and country:match('USA') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
--конец блока флаги стран
				rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. name_rus .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
				desc1 = '<h4><center><font color=#00FA9A>' .. name_rus .. rezka_poisk .. '</font></h4><h5><font color=#BBBBBB>' .. name_eng .. '</font></h5>'
				desc1 = desc1 .. '<h5>' .. country_ID .. ' ' .. country .. ' <font color=#CD7F32>' .. year .. '</font></h5><h5><font color=#BBBBBB>' .. studia .. '</font></h5><h5>' .. genres_str .. '</h5>'
				if director ~= '' and actors ~= '' then
				desc2 = '<font color=#BBBBBB>Режиссер: ' .. director .. '</font><br><font color=#BBBBBB>В ролях: ' .. actors .. '</font>'
				elseif director ~= '' and actors == '' then
				desc2 = '<font color=#BBBBBB>Режиссер: ' .. director .. '</font><br><font color=#BBBBBB>Состав: ' .. sostav .. '</font>'
				end
				desc = answer:match('<b>Описание:</b> (.-)</p>') or ''
	local reting, reting_table = '', ''
	titledesc = country .. ' | ' .. year .. ' | ' .. reting
	if genres ~= '' then titledesc = titledesc .. genres end
-----------------------------------
	t[1] = {}
	t[1].Id = 1
	t[1].Name = name_rus
	t[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background2 .. '><table width="' .. 720*masshtab .. '"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><img src="' .. poster ..
	'" height="' .. 320*masshtab .. '"></td><td style="padding: 10px 5px 0px; color: #EBEBEB; vertical-align: middle;"><h3>' .. titul_rezka_tor .. titul_hevc .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3>' .. desc1 .. reting_table .. '<h5><font color=#CD7F32>' .. alltime ..
	'</font><a href="simpleTVLua:m_simpleTV.Control.ExecuteAction(37) m_simpleTV.Control.ExecuteAction(116)" style="color:#009B76; font-size: small; text-decoration:none"> 🕜 ГЛАВЫ</a></h5>' ..
	'</td><td style="padding: 10px 10px 5px; vertical-align: middle;"><img style="float:right;" src="' .. poster:gsub('-0', '-1') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-2') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-3') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-4') ..
	'" height="' .. 80*masshtab .. '"> </td></tr></table><table width="' .. 720*masshtab .. '"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>'.. desc2 .. 	'</h5><h5>' .. desc .. '</h5></td></tr></table></html>'
	t[1].InfoPanelDesc = t[1].InfoPanelDesc:gsub('"', "\"")
	t[1].InfoPanelTitle = titledesc:gsub('"', '%%22')
	t[1].InfoPanelName = name_rus
	t[1].InfoPanelShowTime = 60000
	t[1].InfoPanelLogo = poster:gsub('-0', '-1')
		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			t.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		else
			t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonPlst then
			t.ExtButton0 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonPlst, ButtonScript = 'm_simpleTV.Control.ExecuteAction(116)'}
		else
			t.ExtButton0 = {ButtonEnable = true, ButtonName = 'CH', ButtonScript = 'm_simpleTV.Control.ExecuteAction(116)'}
		end
--	t.ExtParams = {}
--	t.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_hevcClub'
--	t.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_hevcClub'
--	t.ExtParams.LuaOnTimeoutFunName = 'OnMultiAddressCancel_hevcClub'
	m_simpleTV.OSD.ShowSelect_UTF8('HEVC-CLUB', 0, t, 8000, 32 + 64 + 128)
	m_simpleTV.Control.SetTitle(name_rus)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(poster, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(name_rus, m_simpleTV.Control.ChannelID, false)
	end

		m_simpleTV.OSD.ShowMessageT({text = name_rus, color = 0xff9999ff, showTime = 1000 * 5, id = 'channelName'})
		m_simpleTV.Control.CurrentAddress = retAdr
	else
------------------франшиза
				answer_franshiza = answer:gsub('<summary>Поблагодарили: .-</summary>', ''):gsub('<summary>Файлы: .-</summary>', ''):gsub('<summary>Сиды / Пиры.-</summary>', ''):gsub('<summary>Медиаинфо.-</summary>', ''):gsub('<summary>Лог %(x265 info%).-</summary>', ''):gsub('<summary>Серии.-</summary>', '')
				answer_franshiza = answer_franshiza:match('(<summary>.-)="/action/torrent')
		if answer_franshiza then
		title = title:gsub(' %/.-$', '')
		local i, tab = 1, {}
			for w in answer_franshiza:gmatch('<summary>.-</p>') do
			local franshiza = ''
			local title1 = w:match('<summary>.-</summary>') or 'RIPS-CLUB'
				title1 = title1:gsub(' %[HEVC] .-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&'):gsub(' %/.-$', '')
			local year, country, genres, director, actors, sostav, name, titledesc, desc, desc1, topdesc
				franshiza = w:match('<summary>(.-)</summary>')
				poster = w:match('src="(.-)"') or ''
				poster = url1.. poster
				year = w:match('<b>Год:</b> (.-)<br>') or ''
				country = w:match('<b>Страна:</b> (.-)<br>') or ''
				genres = w:match('<b>Жанр:</b> (.-)<br>') or ''
				genres_str = genres:gsub(',', '')
				genres_str = genres_str:gsub('Биография', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres1_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Биография</a>')
				genres_str = genres_str:gsub('Боевик', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres2_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Боевик</a>')
				genres_str = genres_str:gsub('Вестерн', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres3_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Вестерн</a>')
				genres_str = genres_str:gsub('Военный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres4_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Военный</a>')
				genres_str = genres_str:gsub('Детектив', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres5_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детектив</a>')
				genres_str = genres_str:gsub('Детский', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres6_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детский</a>')
				genres_str = genres_str:gsub('Документальный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres7_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Документальный</a>')
				genres_str = genres_str:gsub('История', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres9_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">История</a>')
				genres_str = genres_str:gsub('Катастрофа', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres26_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Катастрофа</a>')
				genres_str = genres_str:gsub('Комедия', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres10_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Комедия</a>')
				genres_str = genres_str:gsub('Короткометражка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres11_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Короткометражка</a>')
				genres_str = genres_str:gsub('Криминал', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres12_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Криминал</a>')
				genres_str = genres_str:gsub('Мистика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres27_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мистика</a>')
				genres_str = genres_str:gsub('Музыка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres14_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Музыка</a>')
				genres_str = genres_str:gsub('Мультфильм', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres15_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мультфильм</a>')
				genres_str = genres_str:gsub('Мюзикл', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres16_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мюзикл</a>')
				genres_str = genres_str:gsub('Приключения', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres17_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Приключения</a>')
				genres_str = genres_str:gsub('Семейный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres18_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Семейный</a>')
				genres_str = genres_str:gsub('Спорт', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres19_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Спорт</a>')
				genres_str = genres_str:gsub('ТВ', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres20_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">ТВ</a>')
				genres_str = genres_str:gsub('Ток%-шоу', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres21_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ток-шоу</a>')
				genres_str = genres_str:gsub('Триллер', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres22_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Триллер</a>')
				genres_str = genres_str:gsub('Ужасы', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres23_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ужасы</a>')
				genres_str = genres_str:gsub('Фантастика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres24_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фантастика</a>')
				genres_str = genres_str:gsub('Фэнтези', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres25_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фэнтези</a>')
				genres_str = genres_str:gsub('Мелодрама', 'genres_tmp')
				genres_str = genres_str:gsub('Драма', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres8_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Драма</a>')
				genres_str = genres_str:gsub('genres_tmp', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres13_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мелодрама</a>')
				studia = w:match('<b>Студия:</b> (.-)<br>') or ''
				alltime = w:match('<b>Продолжительность:</b> (.-)<br>') or ''
				director = w:match('<b>Режиссер:</b> (.-)<br>') or ''
				actors = w:match('<b>В ролях:</b> (.-)<br>') or ''
				sostav = ''
				if actors == '' then sostav = w:match('<b>Состав:</b><br>(.-)<br>') end
				name = title1:gsub(' %(.-$', ''):gsub('-', '−'):gsub('<summary>', '')
				name_rus = name:gsub(' %/.-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_eng = name:gsub('.-%/ ', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="' .. m_simpleTV.MainScriptDir .. 'user/westSide/country/' .. country_ID .. '.png" height="' .. 36*masshtab .. '" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if country and country:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Южная Корея') or country and country:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('США') or country and country:match('USA') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
--конец блока флаги стран
				rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. name_rus .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
				desc1 = '<h4><center><font color=#00FA9A>' .. name_rus:gsub('^.-%. ', '') .. rezka_poisk .. '</font></h4><h5><font color=#BBBBBB>' .. name_eng .. '</font></h5>'
				desc1 = desc1 .. '<h5>' .. country_ID .. ' ' .. country .. ' <font color=#CD7F32>' .. year .. '</font></h5><h5><font color=#BBBBBB>' .. studia .. '</font></h5><h5>' .. genres_str .. '</h5>'
				if director ~= '' and actors ~= '' then
				desc2 = '<font color=#BBBBBB>Режиссер: ' .. director .. '</font><br><font color=#BBBBBB>В ролях: ' .. actors .. '</font>'
				elseif director ~= '' and actors == '' then
				desc2 = '<font color=#BBBBBB>Режиссер: ' .. director .. '</font><br><font color=#BBBBBB>Состав: ' .. sostav .. '</font>'
				end
				desc = w:match('<b>Описание:</b> (.-)</p>') or ''
				local reting, reting_table = '', ''
				titledesc = country .. ' | ' .. year .. ' | ' .. reting
				if genres ~= '' then titledesc = titledesc .. genres end
					tab[i] = {}
					tab[i].Id = i
					tab[i].Name = name_rus
					tab[i].Address = retAdr .. '$TORRENTINDEX=' .. i - 1
					tab[i].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background2 .. '><table width="' .. 720*masshtab .. '"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><img src="' .. poster ..
	'" height="' .. 320*masshtab .. '"></td><td style="padding: 10px 5px 0px; color: #EBEBEB; vertical-align: middle;"><h3>' .. titul_rezka_tor .. titul_hevc .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3>' .. desc1 .. '<h5><font color=#CD7F32>' .. alltime ..
	'</font><a href="simpleTVLua:m_simpleTV.Control.ExecuteAction(37) m_simpleTV.Control.ExecuteAction(116)" style="color:#009B76; font-size: small; text-decoration:none"> 🕜 ГЛАВЫ</a></h5>' ..
	'</td><td style="padding: 10px 10px 5px; vertical-align: middle;"><img style="float:right;" src="' .. poster:gsub('-0', '-1') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-2') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-3') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-4') ..
	'" height="' .. 80*masshtab .. '"> </td></tr></table><table width="' .. 720*masshtab .. '"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>'.. desc2 .. 	'</h5><h5>' .. desc .. '</h5></td></tr></table></html>'
	tab[i].InfoPanelDesc = tab[i].InfoPanelDesc:gsub('"', "\"")
	tab[i].InfoPanelTitle = titledesc:gsub('"', '%%22')
	tab[i].InfoPanelName = name_rus
	tab[i].InfoPanelShowTime = 60000
	tab[i].InfoPanelLogo = poster:gsub('-0', '-1')
					i = i + 1
			end
			m_simpleTV.User.hevcClub.titleTab = tab
			if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab.OkButton = {ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		else
			tab.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonPlst then
			tab.ExtButton0 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonPlst, ButtonScript = 'm_simpleTV.Control.ExecuteAction(116)'}
		else
			tab.ExtButton0 = {ButtonEnable = true, ButtonName = 'CH', ButtonScript = 'm_simpleTV.Control.ExecuteAction(116)'}
		end
		m_simpleTV.Control.SetTitle(title)
		m_simpleTV.Control.CurrentAddress = tab[1].Address
--	tab.ExtParams = {}
--	tab.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_hevcClub'
--	tab.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_hevcClub'
--	tab.ExtParams.LuaOnTimeoutFunName = 'OnMultiAddressCancel_hevcClub'
	m_simpleTV.OSD.ShowSelect_UTF8(title, 0, tab, 8000, 2 + 64)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(poster1, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, true)
	end
	else
-----------сериал
	local year, country, genres, director, actors, sostav, ses, name, titledesc, desc, desc1, topdesc
				year = answer:match('<b>Год:</b> (.-)<br>') or ''
				country = answer:match('<b>Страна:</b> (.-)<br>') or ''
				genres = answer:match('<b>Жанр:</b> (.-)<br>') or ''
				genres_str = genres:gsub(',', '')
				genres_str = genres_str:gsub('Биография', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres1_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Биография</a>')
				genres_str = genres_str:gsub('Боевик', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres2_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Боевик</a>')
				genres_str = genres_str:gsub('Вестерн', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres3_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Вестерн</a>')
				genres_str = genres_str:gsub('Военный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres4_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Военный</a>')
				genres_str = genres_str:gsub('Детектив', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres5_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детектив</a>')
				genres_str = genres_str:gsub('Детский', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres6_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детский</a>')
				genres_str = genres_str:gsub('Документальный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres7_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Документальный</a>')
				genres_str = genres_str:gsub('История', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres9_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">История</a>')
				genres_str = genres_str:gsub('Катастрофа', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres26_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Катастрофа</a>')
				genres_str = genres_str:gsub('Комедия', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres10_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Комедия</a>')
				genres_str = genres_str:gsub('Короткометражка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres11_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Короткометражка</a>')
				genres_str = genres_str:gsub('Криминал', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres12_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Криминал</a>')
				genres_str = genres_str:gsub('Мистика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres27_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мистика</a>')
				genres_str = genres_str:gsub('Музыка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres14_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Музыка</a>')
				genres_str = genres_str:gsub('Мультфильм', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres15_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мультфильм</a>')
				genres_str = genres_str:gsub('Мюзикл', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres16_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мюзикл</a>')
				genres_str = genres_str:gsub('Приключения', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres17_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Приключения</a>')
				genres_str = genres_str:gsub('Семейный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres18_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Семейный</a>')
				genres_str = genres_str:gsub('Спорт', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres19_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Спорт</a>')
				genres_str = genres_str:gsub('ТВ', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres20_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">ТВ</a>')
				genres_str = genres_str:gsub('Ток%-шоу', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres21_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ток-шоу</a>')
				genres_str = genres_str:gsub('Триллер', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres22_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Триллер</a>')
				genres_str = genres_str:gsub('Ужасы', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres23_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ужасы</a>')
				genres_str = genres_str:gsub('Фантастика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres24_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фантастика</a>')
				genres_str = genres_str:gsub('Фэнтези', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres25_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фэнтези</a>')
				genres_str = genres_str:gsub('Мелодрама', 'genres_tmp')
				genres_str = genres_str:gsub('Драма', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres8_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Драма</a>')
				genres_str = genres_str:gsub('genres_tmp', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres13_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мелодрама</a>')
				studia = answer:match('<b>Студия:</b> (.-)<br>') or ''
				alltime = answer:match('<b>Продолжительность:</b> (.-)<br>') or ''
				director = answer:match('<b>Режиссер:</b> (.-)<br>') or ''
				actors = answer:match('<b>В ролях:</b> (.-)<br>') or ''
				sostav = ''
				if actors == '' then sostav = answer:match('<b>Состав:</b><br>(.-)<br>') end
				ses = title:match('%)(.-)BDRip') or ''
				if not ses:match('сезон') then ses = ''
				else ses = '. ' .. ses:gsub('%[', ''):gsub('%]', '') end
				name = title:gsub(' %(.-$', ''):gsub('-', '−')
				name_rus = name:gsub(' %/.-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				rezka_poisk = ' <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'#' .. name_rus .. '\')"><img src="simpleTVImage:./luaScr/user/westSide/icons/Preview.png" height="' .. 36*masshtab .. '" align="top"></a>'
				name_eng = name:gsub('.-%/ ', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_rus = name_rus .. ses
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="' .. m_simpleTV.MainScriptDir .. 'user/westSide/country/' .. country_ID .. '.png" height="' .. 36*masshtab .. '" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if country and country:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Южная Корея') or country and country:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('США') or country and country:match('USA') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
--конец блока флаги стран
				desc1 = '<h4><center><font color=#00FA9A>' .. name_rus .. rezka_poisk .. '</font></h4><h5><font color=#BBBBBB>' .. name_eng .. '</font></h5>'
				desc1 = desc1 .. '<h5>' .. country_ID .. ' ' .. country .. ' <font color=#CD7F32>' .. year .. '</font></h5><h5><font color=#BBBBBB>' .. studia .. '</font></h5><h5>' .. genres_str .. '</h5>'
				if director ~= '' and actors ~= '' then
				desc2 = '<font color=#BBBBBB>Режиссер: ' .. director .. '</font><br><font color=#BBBBBB>В ролях: ' .. actors .. '</font>'
				elseif director ~= '' and actors == '' then
				desc2 = '<font color=#BBBBBB>Режиссер: ' .. director .. '</font><br><font color=#BBBBBB>Состав: ' .. sostav .. '</font>'
				end
				desc = answer:match('<b>Описание:</b> (.-)</p>') or ''
	local reting, reting_table = '', ''
	titledesc = country .. ' | ' .. year .. ' | ' .. reting
	if genres ~= '' then titledesc = titledesc .. genres end
-----------------------------------
				name = answer:match('<meta property="og:title" content="(.-) [HEVC]') or 'HEVC'
				ses = name:match('%)(.-)BDRip') or ''
				if not ses:match('сезон') then ses = ''
				else ses = '. ' .. ses:gsub('%[', ''):gsub('%]', '') end
				name = name:gsub(' %(.-$', ''):gsub('-', '−')
				name_rus = name:gsub(' %/.-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_eng = name:gsub('.-%/ ', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_rus = name_rus .. ses
		local i = 1
		local episode
		answer_files = answer:match('<div><ul class="files">.-(<ul>.-)</ul></div>')
		answer_files = answer_files:gsub('<li>cover.png.-</li>', '')
				for w in answer_files:gmatch('<li>(.-)</li>') do
				episode = w:gsub('&nbsp;', ' '):gsub('<b>', ''):gsub('</b>', ''):gsub('%.E', 'E')
					t[i] = {}
					t[i].Id = i
					t[i].Name = episode:gsub('%.mkv.-$', ''):gsub('^.-%.S%d+E%d+%.', ''):gsub('^.-%.S%d+E%d+', ''):gsub('S%d+E%d+', ''):gsub('S%d+%.E%d+', ''):gsub('%.', ' '):gsub(' BDRip.-$', ''):gsub('^.-<ul><li>', '')
					s, e = episode:match('S(%d+)E(%d+)')
					if s and e then t[i].Name = tonumber(s) .. ' сезон ' .. tonumber(e) .. ' серия - ' .. t[i].Name end
					t[i].Address = retAdr .. '$TORRENTINDEX=' .. i - 1
					t[i].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background2 .. '><table width="' .. 720*masshtab .. '"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><img src="' .. poster ..
	'" height="' .. 320*masshtab .. '"></td><td style="padding: 10px 5px 0px; color: #EBEBEB; vertical-align: middle;"><h3>' .. titul_rezka_tor .. titul_hevc .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3>' .. desc1 .. '<h5><font color=#CD7F32>' .. alltime ..
	'</font><a href="simpleTVLua:m_simpleTV.Control.ExecuteAction(37) m_simpleTV.Control.ExecuteAction(116)" style="color:#009B76; font-size: small; text-decoration:none"> 🕜 ГЛАВЫ</a></h5>' ..
	'</td><td style="padding: 10px 10px 5px; vertical-align: middle;"><img style="float:right;" src="' .. poster:gsub('-0', '-1') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-2') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-3') ..
	'" height="' .. 80*masshtab .. '"> <img style="float:right;" src="' .. poster:gsub('-0', '-4') ..
	'" height="' .. 80*masshtab .. '"> </td></tr></table><table width="' .. 720*masshtab .. '"><tr><td style="padding: 0px 10px 5px; color: #EBEBEB; vertical-align: middle;"><h5>'.. desc2 .. 	'</h5><h5>' .. desc .. '</h5></td></tr></table></html>'
	t[i].InfoPanelDesc = t[i].InfoPanelDesc:gsub('"', "\"")
	if e then
	t[i].InfoPanelTitle = titledesc:gsub('"', '%%22') .. ' - ' .. tonumber(e) .. ' серия' else t[i].InfoPanelTitle = titledesc:gsub('"', '%%22') end
	t[i].InfoPanelName = name_rus
	t[i].InfoPanelShowTime = 60000
	t[i].InfoPanelLogo = poster:gsub('-0', '-1')
					i = i + 1
			end
			m_simpleTV.User.hevcClub.titleTab = t
			if m_simpleTV.User.paramScriptForSkin_buttonOk then
			t.OkButton = {ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			t.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		else
			t.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonPlst then
			t.ExtButton0 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonPlst, ButtonScript = 'm_simpleTV.Control.ExecuteAction(116)'}
		else
			t.ExtButton0 = {ButtonEnable = true, ButtonName = 'CH', ButtonScript = 'm_simpleTV.Control.ExecuteAction(116)'}
		end
	m_simpleTV.Control.CurrentAddress = t[1].Address
	m_simpleTV.Control.SetTitle(title)
	t.ExtParams = {}
	t.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_hevcClub'
	t.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_hevcClub'
	t.ExtParams.LuaOnTimeoutFunName = 'OnMultiAddressCancel_hevcClub'
	m_simpleTV.OSD.ShowSelect_UTF8(name_rus, 0, t, 8000, 2 + 64)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(poster1, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title, m_simpleTV.Control.ChannelID, false)
	end
	end
	end
	else
-------------блок запроса
    answer = answer:gsub('\n', ' ')
	m_simpleTV.Control.CurrentAddress = retAdr
	local title_zapros = answer:match('"og:title" content="([^"]+)') or 'HEVC-CLUB'
				title_zapros = title_zapros:gsub(' %[HEVC] .-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
		local t, i, desc_zapros = {}, 1, ''
		local name, adr, logo
			for w in answer:gmatch('<section><div class="title"><h2><a (.-)</section>') do
				name = w:match('title="Подробнее">(.-)</a></h2></div>')
				ses = name:match('%)(.-)BDRip') or ''
				if not ses:match('сезон') then ses = ''
				else ses = '. ' .. ses:gsub('%[', ''):gsub('%]', '') end
				name = name:gsub(' %(.-$', ''):gsub('-', '−')
				name_rus = name:gsub(' %/.-$', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_eng = name:gsub('.-%/ ', ''):gsub('&apos;', '´'):gsub('&amp;', '&')
				name_rus = name_rus .. ses
				da = w:match('<time title="Дата добавления".->(.-)&nbsp;&nbsp;')
				year = w:match('<b>Год:</b> (.-)<br>') or ''
				country = w:match('<b>Страна:</b> (.-)<br>') or ''
				genres = w:match('<b>Жанр:</b> (.-)<br>') or ''
--------ссылки на жанры
				genres1_adr = 'https://rips.club/search/?page=1&cat=1'
				genres2_adr = 'https://rips.club/search/?page=1&cat=2'
				genres3_adr = 'https://rips.club/search/?page=1&cat=3'
				genres4_adr = 'https://rips.club/search/?page=1&cat=4'
				genres5_adr = 'https://rips.club/search/?page=1&cat=5'
				genres6_adr = 'https://rips.club/search/?page=1&cat=6'
				genres7_adr = 'https://rips.club/search/?page=1&cat=7'
				genres8_adr = 'https://rips.club/search/?page=1&cat=8'
				genres9_adr = 'https://rips.club/search/?page=1&cat=9'
				genres10_adr = 'https://rips.club/search/?page=1&cat=10'
				genres11_adr = 'https://rips.club/search/?page=1&cat=11'
				genres12_adr = 'https://rips.club/search/?page=1&cat=12'
				genres13_adr = 'https://rips.club/search/?page=1&cat=13'
				genres14_adr = 'https://rips.club/search/?page=1&cat=14'
				genres15_adr = 'https://rips.club/search/?page=1&cat=15'
				genres16_adr = 'https://rips.club/search/?page=1&cat=16'
				genres17_adr = 'https://rips.club/search/?page=1&cat=17'
				genres18_adr = 'https://rips.club/search/?page=1&cat=18'
				genres19_adr = 'https://rips.club/search/?page=1&cat=19'
				genres20_adr = 'https://rips.club/search/?page=1&cat=20'
				genres21_adr = 'https://rips.club/search/?page=1&cat=21'
				genres22_adr = 'https://rips.club/search/?page=1&cat=22'
				genres23_adr = 'https://rips.club/search/?page=1&cat=23'
				genres24_adr = 'https://rips.club/search/?page=1&cat=24'
				genres25_adr = 'https://rips.club/search/?page=1&cat=25'
				genres26_adr = 'https://rips.club/search/?page=1&cat=26'
				genres27_adr = 'https://rips.club/search/?page=1&cat=27'
				genres_str = genres:gsub(',', '')
				genres_str = genres_str:gsub('Биография', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres1_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Биография</a>')
				genres_str = genres_str:gsub('Боевик', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres2_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Боевик</a>')
				genres_str = genres_str:gsub('Вестерн', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres3_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Вестерн</a>')
				genres_str = genres_str:gsub('Военный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres4_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Военный</a>')
				genres_str = genres_str:gsub('Детектив', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres5_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детектив</a>')
				genres_str = genres_str:gsub('Детский', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres6_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Детский</a>')
				genres_str = genres_str:gsub('Документальный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres7_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Документальный</a>')
				genres_str = genres_str:gsub('История', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres9_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">История</a>')
				genres_str = genres_str:gsub('Катастрофа', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres26_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Катастрофа</a>')
				genres_str = genres_str:gsub('Комедия', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres10_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Комедия</a>')
				genres_str = genres_str:gsub('Короткометражка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres11_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Короткометражка</a>')
				genres_str = genres_str:gsub('Криминал', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres12_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Криминал</a>')
				genres_str = genres_str:gsub('Мистика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres27_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мистика</a>')
				genres_str = genres_str:gsub('Музыка', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres14_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Музыка</a>')
				genres_str = genres_str:gsub('Мультфильм', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres15_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мультфильм</a>')
				genres_str = genres_str:gsub('Мюзикл', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres16_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мюзикл</a>')
				genres_str = genres_str:gsub('Приключения', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres17_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Приключения</a>')
				genres_str = genres_str:gsub('Семейный', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres18_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Семейный</a>')
				genres_str = genres_str:gsub('Спорт', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres19_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Спорт</a>')
				genres_str = genres_str:gsub('ТВ', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres20_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">ТВ</a>')
				genres_str = genres_str:gsub('Ток%-шоу', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres21_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ток-шоу</a>')
				genres_str = genres_str:gsub('Триллер', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres22_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Триллер</a>')
				genres_str = genres_str:gsub('Ужасы', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres23_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Ужасы</a>')
				genres_str = genres_str:gsub('Фантастика', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres24_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фантастика</a>')
				genres_str = genres_str:gsub('Фэнтези', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres25_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Фэнтези</a>')
				genres_str = genres_str:gsub('Мелодрама', 'genres_tmp')
				genres_str = genres_str:gsub('Драма', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres8_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Драма</a>')
				genres_str = genres_str:gsub('genres_tmp', ' 🔶 <a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. genres13_adr .. '\')" style="color: #BBBBBB; text-decoration: none;">Мелодрама</a>')
--------
				studia = w:match('<b>Студия:</b> (.-)<br>') or ''
				alltime = w:match('<b>Продолжительность:</b> (.-)<br>') or ''
				adr = w:match('href="/(.-)"')
				logo_z = w:match('<img src="(.-)"') or ''
				desc = w:match('<div class="about"><p>(<b>Описание:</b>.-)</p></div>') or w:match('div class="about"><br><details><summary>(Состав:</summary><div>.-)<br></div></details></div>') or w:match('<div class="about"><br>(<b>Состав:</b><br>.-)</div>') or ''
				desc = desc:gsub('Состав:', '<i><font color=#CD7F32>Состав:  </font></i>'):gsub('<b>Описание:</b>', ''):gsub('</summary><div>', '')
-- Флаги стран
                            local function get_country_flags(country_ID)
					        country_flag = '<img src="' .. m_simpleTV.MainScriptDir .. 'user/westSide/country/' .. country_ID .. '.png" height="' .. 36*masshtab .. '" align="top">'
					        return country_flag:gsub('"', "'")
							end
							local tmp_country_ID = ''
							country_ID = ''
							if country and country:match('СССР') then tmp_country_ID = 'ussr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Аргентина') then tmp_country_ID = 'ar' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австрия') then tmp_country_ID = 'at' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Австралия') then tmp_country_ID = 'au' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бельгия') then tmp_country_ID = 'be' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Бразилия') then tmp_country_ID = 'br' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Канада') then tmp_country_ID = 'ca' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швейцария') then tmp_country_ID = 'ch' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Китай') then tmp_country_ID = 'cn' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Гонконг') then tmp_country_ID = 'hk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Германия') then tmp_country_ID = 'de' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Дания') then tmp_country_ID = 'dk' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Испания') then tmp_country_ID = 'es' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Финляндия') then tmp_country_ID = 'fi' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Франция') then tmp_country_ID = 'fr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Великобритания') then tmp_country_ID = 'gb' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Греция') then tmp_country_ID = 'gr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Ирландия') then tmp_country_ID = 'ie' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Израиль') then tmp_country_ID = 'il' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Индия') then tmp_country_ID = 'in' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Исландия') then tmp_country_ID = 'is' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Италия') then tmp_country_ID = 'it' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Япония') then tmp_country_ID = 'jp' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Южная Корея') or country and country:match('Корея Южная') then tmp_country_ID = 'kr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Мексика') then tmp_country_ID = 'mx' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Нидерланды') then tmp_country_ID = 'nl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Норвегия') then tmp_country_ID = 'no' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Польша') then tmp_country_ID = 'pl' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Венгрия') then tmp_country_ID = 'hu' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Новая Зеландия') then tmp_country_ID = 'nz' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Португалия') then tmp_country_ID = 'pt' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Румыния') then tmp_country_ID = 'ro' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('ЮАР') then tmp_country_ID = 'rs' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Россия') then tmp_country_ID = 'ru' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Швеция') then tmp_country_ID = 'se' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Турция') then tmp_country_ID = 'tr' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('Украина') then tmp_country_ID = 'ua' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
							if country and country:match('США') or country and country:match('USA') then tmp_country_ID = 'us' country_ID = get_country_flags(tmp_country_ID) .. country_ID end
--конец блока флаги стран
				desc1 = '<h5>' .. country_ID .. ' ' .. country .. ' <font color=#CD7F32>' .. year .. '</font></h5><h5><font color=#BBBBBB>' .. studia .. '</font></h5><h5>' .. genres_str .. '</h5><h5><font color=#CD7F32>' .. alltime .. '</font></h5>'
				desc_logo = logo_z:gsub('/cover_mini/', '/'):gsub('%.jpg.-$', '-0.jpg')
					if not name or not adr then break end
				t[i] = {}
				t[i].address = url1 .. '/' .. adr
				t[i].desc_logo = url1 .. desc_logo
				t[i].video_desc = '<table width="99%"><tr><td style="padding: 10px 10px 5px; vertical-align: middle;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. t[i].address ..
				'\')"><img src="' .. t[i].desc_logo .. '" height = "' .. 250*masshtab .. '"></a></td><td style="padding: 20px 5px 0px; color: #EBEBEB; vertical-align: middle;"><h4><font color=#00FA9A>' .. name_rus ..
				'</font></h4><h5><font color=#BBBBBB>' .. name_eng .. '</h5>' .. desc1 .. '</td></tr></table><table width="99%"><tr><td style="padding: 10px 0px 5px; color: #EEEEEE; vertical-align: middle;"><h5>' .. desc .. '</h5></td></tr><hr></table>'
				t[i].video_desc = t[i].video_desc:gsub('"', '\"')
				desc_zapros = desc_zapros .. t[i].video_desc
			    i = i + 1
			end
------------------
	local page_str = ''
	if inAdr:match('/search/') then  url2 =  url1 .. '/search' else url2 =  url1 end
	answer_page = answer:match('<ul class="pn">(.-)</ul>')
	if answer_page then
	answer_page = answer_page:gsub('&amp;', '&')
	answer_page = m_simpleTV.Common.multiByteToUTF8(answer_page)
	answer_page = answer_page:gsub('</li>', ' '):gsub('<li>', ''):gsub('<li class="c_page">', ''):gsub('<li class="ellipsis">', '')
	answer_page = answer_page:gsub('<a href="', '<a href = "simpleTVLua:m_simpleTV.Control.PlayAddress%(\'' .. url2 .. '/'):gsub('">', '\'\)" style="color: #BBBBBB; text-decoration: none;">')
	page_str = '<font color=#EBEBEB>Серфинг по страницам: </font>' .. answer_page
	page_str = '<table width="99%"><tr><td style="color: #CD7F32;"><center><h4>' .. page_str .. '</h4></td></tr></table>'
	else page_str = ''
	end
------------------
	local desc_top = ''
	answer_top = answer:match('<div class="top">(.-)</div>')
	if answer_top then
	local k, desc_top1, desc_top2 = 1, '', ''
	for w1 in answer_top:gmatch('<a href=".-</a>') do
	adr_top = w1:match('href="(.-)"')
	logo_top = w1:match('<img src="(.-)"')
	if not adr_top or not logo_top then return end
	adr_top = url1 .. adr_top
	logo_top = url1 .. logo_top:gsub('/top/', '/'):gsub('%.jpg.-$', '-0.jpg')
	if k >= 1 and k <= 5 then
	desc_top1 = desc_top1 .. '<td style="padding: 0px 10px 5px;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adr_top ..
	'\')"><img src="' .. logo_top .. '" height = "' .. 250*masshtab .. '" width = "' .. 166*masshtab .. '"></a></td>' end
	if k >= 6 and k <= 10 then
	desc_top2 = desc_top2 .. '<td style="padding: 10px 10px 10px;"><a href = "simpleTVLua:m_simpleTV.Control.PlayAddress(\'' .. adr_top ..
	'\')"><img src="' .. logo_top .. '" height = "' .. 250*masshtab .. '" width = "' .. 166*masshtab .. '"></a></td>' end
	k = k + 1
	end
	desc_top = '<table width="99%%"><tr>' .. desc_top1 .. '</tr><tr>' .. desc_top2 .. '</tr></table>'
	else desc_top = ''
	end
------------------
local tab_zapros = {}
		tab_zapros[1] = {}
		tab_zapros[1].Id = 1
		tab_zapros[1].Name = title_zapros
		tab_zapros[1].address = background_chanel
		tab_zapros[1].InfoPanelTitle = 'HEVC или H.265 - формат сжатия видеоизображения с применением более эффективных алгоритмов по сравнению с H.264/MPEG-4 AVC, что позволяет на выходе получить видео высокого качества и меньшего размера (в основном примерно на 20% при одинаковом качестве).'
		tab_zapros[1].InfoPanelName = 'Поиск по сайту'
		tab_zapros[1].InfoPanelShowTime = 60000
	    tab_zapros[1].InfoPanelLogo = 'https://rips.club/img/header.jpg'
		tab_zapros[1].InfoPanelDesc = '<html><body bgcolor="#434750" ' .. background1 .. '><table width="99%%"><tr><td colspan="5"><h3><center>' .. titul_rezka_tor .. titul_hevc .. ' <font color=#CD7F32><b>' .. data .. ' </b></font>' .. titul_yt .. titul_rezka .. titul_lostfilm .. '</h3></td></tr><hr>' .. start_search .. desc_top .. '</html><html><body bgcolor="#434750" ' .. background1 .. '>' .. page_str .. desc_zapros .. page_str .. '</html>'
		tab_zapros[1].InfoPanelDesc = tab_zapros[1].InfoPanelDesc:gsub('"', '\"')
		tab_zapros[1].InfoPanelTitle = tab_zapros[1].InfoPanelTitle:gsub('"', '\"')

		if m_simpleTV.User.paramScriptForSkin_buttonOk then
			tab_zapros.OkButton = {ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonOk}
		end
		if m_simpleTV.User.paramScriptForSkin_buttonClose then
			tab_zapros.ExtButton1 = {ButtonEnable = true, ButtonImageCx = 30*masshtab, ButtonImageCy = 30*masshtab, ButtonImage = m_simpleTV.User.paramScriptForSkin_buttonClose, ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		else
			tab_zapros.ExtButton1 = {ButtonEnable = true, ButtonName = '✕', ButtonScript = 'OnMultiAddressCancel_hevcClub()'}
		end
	tab_zapros.ExtParams = {}
	tab_zapros.ExtParams.LuaOnCancelFunName = 'OnMultiAddressCancel_hevcClub'
	tab_zapros.ExtParams.LuaOnOkFunName = 'OnMultiAddressOk_hevcClub'
	tab_zapros.ExtParams.LuaOnTimeoutFunName = 'OnMultiAddressCancel_hevcClub'
	m_simpleTV.OSD.ShowSelect_UTF8('HEVC-CLUB', 0, tab_zapros, 8000, 32 + 64 + 128)
	if m_simpleTV.Control.MainMode == 0 then
		m_simpleTV.Control.ChangeChannelLogo(poster, m_simpleTV.Control.ChannelID, 'CHANGE_IF_NOT_EQUAL')
		m_simpleTV.Control.ChangeChannelName(title_zapros, m_simpleTV.Control.ChannelID, false)
	end
	m_simpleTV.Control.ExecuteAction(108,0)
	m_simpleTV.Control.ExecuteAction(108,1)
--------------конец блока запроса
	end
-- debug_in_file(retAdr .. '\n')